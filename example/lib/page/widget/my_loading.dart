
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class MyLoading {
  MyLoading._internal();
  factory MyLoading() => _instance;
  static final MyLoading _instance = MyLoading._internal();

  static bool isShow = false;

  static show() {
    EasyLoading.instance
      ..userInteractions = false
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 48.0
      ..boxShadow = [BoxShadow(color: Colors.transparent)]
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.transparent
      ..maskColor = Colors.transparent
      ..maskType = EasyLoadingMaskType.none;

    EasyLoading.show(indicator: Container(
        width: 48,
        height: 48,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, spreadRadius: 0)]),
        child: CircularProgressIndicator()),);
    isShow = true;
  }

  static dismiss() {
    EasyLoading.dismiss();
    isShow = false;
  }

  static showToast(String content,{Duration? duration}) {
    EasyLoading.instance
    ..maskColor = Colors.transparent
      ..loadingStyle = EasyLoadingStyle.dark;
    EasyLoading.showToast(content,maskType: EasyLoadingMaskType.custom,duration: duration);
  }
}
