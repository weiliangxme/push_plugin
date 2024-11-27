import 'dart:async';

import 'package:push_plugin/api/api_path.dart';
import 'package:push_plugin/api/network/network.dart';
import 'package:push_plugin/model/MessageContentModel.dart';
import 'package:push_plugin/model/MessageSummaryModel.dart';
import 'package:push_plugin/model/base_data.dart';
import 'package:push_plugin/model/notification_setting.dart';
import 'package:push_plugin/utils/constants.dart';





class PushApi {
  ///   注册推送id到服务器
  ///   platform：推送渠道
  ///   id：推送token
  static void registerPushNotificationId(platform, id) async {
    Network.post(
      ApiPath.pushUrl + ApiPath.registerPushId,
      params: {
        "platform": platform,
        "registrationId": id,
        "version": Constants.version, //需要动态获取自己的版本
        "language": Constants.language, //需要动态获取app语言，服务端会根据当前注册语言来推对应语言的通知
        "channel": Constants.channel, //需要动态获取自己的渠道 是谷歌还是iOS
        "env": null
      },
    );
  }

  ///   注销用户推送id
  static void unRegisterPushId() async {
    Network.post(
      ApiPath.pushUrl + ApiPath.unRegisterPushId,
    );
  }

  /// 上报通知点击事件
  static void reportPushClick(String sendPlanDetailId) {
    Network.put("${ApiPath.pushUrl}${ApiPath.reportPushClick}/$sendPlanDetailId");
  }

  /// 上报通知查看事件
  static void setNotificationRead(String messageId) {
    Network.put("${ApiPath.pushUrl}${ApiPath.setNotificationRead}/$messageId");
  }

  ///Clear all unread messages
  static Future<bool> updateReadStateAll() {
    Completer<bool> completer = Completer();
    Network.dio.put(ApiPath.pushUrl + ApiPath.updateReadStateAll).then((value) {
      BaseResponseModel responseModel = BaseResponseModel.fromJson(value.data);
      if (responseModel.success) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    });
    return completer.future;
  }


  static Future<List<MessageSummaryModel>> getMessageCenterData() async {
    var response = await Network.get(
      ApiPath.pushUrl + ApiPath.getMessageCenterData,);
    var responseModel = BaseResponseModel.fromJson(response);
    if(responseModel.success){
      List<dynamic> data = responseModel.data;
      List<MessageSummaryModel> models = data.map((e) => MessageSummaryModel.fromJson(e)).toList();
      return models;
    }else{
      return [];
    }
  }


  static Future<MessageDataModel> getMessageListByType(String  messageType,{int pageNo = 0, int pageSize = 20}) async {
    var params = {
      'messageType':messageType,
      'page':pageNo,
      'size':pageSize,
      'sort': 'createTime,DESC'
    };
    var response = await Network.get(
        ApiPath.pushUrl + ApiPath.getMessageListByType,params:params );
    var responseModel = BaseResponseModel.fromJson(response);
    if(responseModel.success){
      return MessageDataModel.fromJson(responseModel.data);
    }else{
      return Future.error(responseModel.message);
    }
  }


  static Future<BaseResponseModel> changeNotificationState(int id, bool openFlag) async {
    Completer<BaseResponseModel> completer = Completer();
    Network.post(ApiPath.pushUrl + ApiPath.changeNotificationState, params: {'id': id, 'openFlag': openFlag})
        .then((value) {
      BaseResponseModel responseModel = BaseResponseModel.fromJson(value);
      completer.complete(responseModel);
    });
    return completer.future;
  }

  static Future<List<NotificationSetting>> getUserNotificationStates() async {
    Completer<List<NotificationSetting>> completer = Completer();
    Network.get(ApiPath.pushUrl + ApiPath.getUserNotificationStates).then((value) {
      BaseResponseModel responseModel = BaseResponseModel.fromJson(value);
      if (responseModel.success && responseModel.data != null) {
        List<NotificationSetting> settings =
        responseModel.data.map<NotificationSetting>((item) => NotificationSetting.fromJson(item)).toList();
        settings.map((e) {
          if (e.messageType == "OFFICIAL") {
            e.subMessageTypeStateResps.map((e1) {
              if (e1.id == 7) {
                // LocalDataTool.setMintNotificationEnable(e1.openState);
              }
            }).toList();
          }
        }).toList();
        completer.complete(settings);
      } else {
        completer.complete([]);
      }
    });
    return completer.future;
  }

  static Future<BaseResponseModel> updateUserNotificationState(bool openFlag) async {
    Completer<BaseResponseModel> completer = Completer();
    Network.post(ApiPath.pushUrl + ApiPath.updateUserNotificationState, params: {'openFlag': openFlag})
        .then((value) {
      BaseResponseModel responseModel = BaseResponseModel.fromJson(value);
      completer.complete(responseModel);
    });
    return completer.future;
  }
}
