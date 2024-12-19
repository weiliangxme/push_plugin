import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:push_plugin/api/api_path.dart';
import 'package:push_plugin/api/network/network.dart';
import 'package:push_plugin/api/push_api.dart';
import 'package:push_plugin/utils/constants.dart';
import 'apns/apns.dart';
import 'model/jump_event.dart';
import 'android_push/android_push.dart';
import 'model/push_click_model.dart';
import 'push_plugin_platform_interface.dart';
// import 'package:package_info_plus/package_info_plus.dart';
export 'model/jump_event.dart';
export 'model/push_click_model.dart';
export 'api/push_api.dart';
export 'package:push_plugin/model/base_data.dart';
export 'package:push_plugin/model/MessageContentModel.dart';
export 'package:push_plugin/model/MessagePayload.dart';
export 'package:push_plugin/model/MessageSummaryModel.dart';
export 'package:push_plugin/model/notification_setting.dart';

class PushPlugin {
  PushPlugin._internal();
  factory PushPlugin() => _instance;
  static final PushPlugin _instance = PushPlugin._internal();

  final _jumpController = StreamController<JumpEvent>.broadcast();
  Stream<JumpEvent> get jumpEvent => _jumpController.stream;

  String _channel = '';

  Future<String?> getPlatformVersion() {
    return PushPluginPlatform.instance.getPlatformVersion();
  }

  Future<void> init({required String baseUrl,required String appId,required String uid,required String version,required String language})async{
    await _initParams(baseUrl: baseUrl,appId:appId,uid: uid,version:version,language: language);
    await Network.buildDio();
    if(Platform.isIOS){
      final connector = createPushConnector();
      connector.configure(
        onLaunch: (data) => _iosOpenNotification('onLaunch', data),
        onResume: (data) => _iosOpenNotification('onResume', data),
        onMessage: (data) => _iosOpenNotification('onMessage', data),
        onBackgroundMessage: (data) => _iosOpenNotification('onBackgroundMessage', data),
      );

      // Displaying notification while in foreground
      if(connector is ApnsPushConnector){
        connector.shouldPresent = (x) => Future.value(true);
      }

      connector.token.addListener(() {
        PushApi.registerPushNotificationId('apns', connector.token.value);
      });

      connector.requestNotificationPermissions();
    }else{
      AndroidPush.addEventListener(
          onReceivedToken: (String message) async {
            Map map;
            if (message.contains('"')) {
              map = convert.jsonDecode(message);
            } else {
              map = <String, String>{};
              var tmp = message.trim();
              tmp.substring(1, tmp.length - 1).split(",").forEach((x) {
                map[x.split("=")[0].trim()] = x.split("=")[1].trim();
              });
            }
            String rid = map["registrationId"] ?? map["token"];
            String platform = map["platform"];
            _channel = platform;
            PushApi.registerPushNotificationId(platform, rid);
          },
          onReceiveNotification: (String message) async {},
          onOpenNotification: (String message) async {
            _androidOpenNotification(message);
          },
          onReceiveMessage: (String message) async {}
      );
    }
  }

  unregisterDevice(){
    PushApi.unRegisterPushId();
  }

  Future<void> _initParams({required String baseUrl,required String appId ,required String uid,required String version,required String language})async{
    // var info = await PackageInfo.fromPlatform();
    Constants.baseUrl = baseUrl;
    ApiPath.pushUrl = baseUrl;
    Constants.uid = uid;
    Constants.language = language;
    Constants.channel = Platform.isIOS ? Constants.appstore : Constants.googlePlay;
    Constants.version = version;
    Constants.appId =appId;
  }

  Future<dynamic> _iosOpenNotification(String name, Map<String, dynamic> data) {
    _handleClickEvent(PushClickModel.fromJson(convert.jsonDecode(data['payload'])));
    return Future.value(true);
  }

  _androidOpenNotification(String message) {
    try{
      Map<String, dynamic> map = {};
      switch (_channel) {
        case 'google':
          try{
            if(message.contains("payload")){
              message = message.substring(1, message.length - 1);
              message = message.substring(message.indexOf('{'), message.indexOf('}') + 1);
              message = message.replaceAll("'", "\"");
              map = convert.json.decode(message);
            }else{
              message = message.replaceAll('{', '').replaceAll('}', '');
              var keyValuePairs = message.split(', ');
              for (var pair in keyValuePairs) {
                var splitPair = pair.split('=');
                if(splitPair[0] == "browserOpenType"||splitPair[0] == "dappFlag"||splitPair[0] == "jumpType"){
                  map[splitPair[0]] = bool.parse(splitPair[1]);
                }else if(splitPair[0] == "joinId"){
                  map[splitPair[0]] = int.parse(splitPair[1]);
                }else{
                  map[splitPair[0]] = splitPair[1];
                }
              }
              map['inUrl'] = [map['inUrl_0'],map['inUrl_1']];
            }
          }catch(e){
            print("++++++push receive google push data catch :$e");
          }
          break;
        case 'mi':
          try{
            if (message.contains("{{")) {
              message = message.substring(message.indexOf('{{') + 1, message.indexOf('}}') + 1);
              map = convert.json.decode(message);
            } }catch(e){
            print("++++++push receive mi push data catch :$e");
          }
          break;
        case 'oppo':
        case 'meizu':
        case 'huawei':
        case 'honor':
          try{
            message = message.substring(1, message.length - 1);
            message.split(', ').forEach((ele) {
              String key = ele.substring(0, ele.indexOf('='));
              String value = ele.substring(ele.indexOf('=') + 1);
              if (key == 'inUrl') {
                map[key] = value.replaceAll('\"', '').replaceAll('[', '').replaceAll(']', '').split(',').toList();
              } else if(key == 'dappFlag'){
                map[key] = bool.parse(value);
              }else if(key == 'jumpType'){
                map[key] = bool.parse(value);
              }else if(key == 'browserOpenType'){
                map[key] = bool.parse(value);
              }else if(key == 'joinId'){
                map[key] = int.parse(value);
              } else{
                map[key] = value;
              }
            });
          }catch(e){
            print("PushPlugin _androidOpenNotification honor catch:$e");
          }
          break;
        case 'vivo':
          break;
        default:
          map = {};
      }
      if (map.isNotEmpty) {
        _handleClickEvent(PushClickModel.fromJson(map));
      }
    }catch(e){
      print("PushPlugin _androidOpenNotification catch:$e");
    }
  }


  _handleClickEvent(PushClickModel pushClickModel){
    PushApi.setNotificationRead(pushClickModel.messageId);
    PushApi.reportPushClick(pushClickModel.sendPlanDetailId);
    if (pushClickModel.jumpType == null) {
      return;
    }
    if (pushClickModel.jumpType) {
      String page = pushClickModel.inUrl[1].replaceAll(' ', '');
      _jumpController.add(JumpEvent(jumpType: JumpType.internalPage,page: page,extra: pushClickModel));
    } else {
      String url = pushClickModel.outUrl;
      if (url == null) {
        return;
      }
      if (pushClickModel.browserOpenType) {
        _jumpController.add(JumpEvent(jumpType: JumpType.inAppWebView,url: url,extra: pushClickModel));
      } else {
        _jumpController.add(JumpEvent(jumpType: JumpType.systemWebView,url: url,extra: pushClickModel));
      }
    }
  }

}