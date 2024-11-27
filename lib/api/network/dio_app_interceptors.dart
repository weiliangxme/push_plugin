import 'dart:convert';
import 'dart:io';
import 'package:push_plugin/utils/constants.dart';

const String CLIENT_INFO = "clientInfo";

class AppInterceptor {

  static requestExecute(Map<String, dynamic>? param, {showLoading = false}) {
    return supplementGenericData(param);
  }

  static supplementGenericData(Map<String, dynamic>? param) async {
    String genericData = jsonEncode({
      'language': Constants.language,
      'os': Platform.isAndroid?'android':'ios',
      'uid':Constants.uid,
      'version': Constants.version,
    });
    param ??= {};
    param[CLIENT_INFO] = genericData;
    return param;
  }



  static supplementGenericDataPost(String url) async {
    String genericData = jsonEncode({
      'language': Constants.language,
      'os':Platform.isAndroid?'android':'ios',
      'uid':Constants.uid,
      'version': Constants.version,
    });
    if(url.contains("?")){
      url = "$url&clientInfo=${Uri.encodeComponent(genericData)}";
    }else{
      url = "$url?clientInfo=${Uri.encodeComponent(genericData)}";
    }

    return url;
  }


}

class BaseModel {
  String? code;
  int? errorCode;
  String? errorName;
  String? msg;
  dynamic data;

  BaseModel.jsonToModel(Map<String, dynamic> json) {
    code = json['code'].toString();
    errorCode = json['errorCode'];
    errorName = json['errorName'];
    msg = json['msg'];
    data = json["data"];
  }

  Map<String, dynamic> modelToJson() {
    return {
      'code': code,
      'errorCode': errorCode,
      'errorName': errorName,
      'msg': msg,
      'data': data
    };
  }
}
