import 'dart:async';

import 'package:flutter/services.dart';
typedef Future<dynamic> EventHandler(String event);

class AndroidPush{
  static const MethodChannel _channel =
  const MethodChannel('flutter_plugin_push');

  static late EventHandler _onReceiveNotification;
  static late EventHandler _onOpenNotification;
  static late EventHandler _onReceiveMessage;
  static late EventHandler _onReceivedToken;

  //通知/自定义消息的事件回调
  static void addEventListener({required EventHandler onReceivedToken,required EventHandler onReceiveNotification,required EventHandler onOpenNotification,required EventHandler onReceiveMessage }){
    print('添加事件监听');
    _init();
    AndroidPush._onReceivedToken=onReceivedToken;
    AndroidPush._onReceiveNotification=onReceiveNotification;
    AndroidPush._onReceiveMessage=onReceiveMessage;
    AndroidPush._onOpenNotification=onOpenNotification;

    _channel.setMethodCallHandler(_handleMethod);
  }
  static Future<dynamic> _handleMethod(MethodCall call) async {
    // print('执行的函数:'+call.method+'，参数:'+call.arguments.cast<String, dynamic>().toString());
    switch (call.method) {
      case "onReceivedToken":
        return _onReceivedToken(call.arguments);
      case "onReceiveNotification":
        return _onReceiveNotification(call.arguments);
      case "onOpenNotification":
        return _onOpenNotification(call.arguments);
      case "onReceiveMessage":
        return _onReceiveMessage(call.arguments);
      default:
        throw new UnsupportedError("Unrecognized Event");
    }
  }

  static void _init() async  {
    return await _channel.invokeMethod('init');
  }

}