import 'dart:async';

import 'package:flutter/services.dart';

class MzRsaPlugin {
  static const MethodChannel _channel = const MethodChannel('mz_rsa_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 公钥加密
  static Future<String> encryptStringByPublicKey(
      String string, String publicKey) async {
    return await _channel.invokeMethod(
        'encryptStringByPublicKey', {"string": string, "publicKey": publicKey});
  }

  /// 公钥解密
  static Future<String> decryptStringByPublicKey(
      String string, String publicKey) async {
    return await _channel.invokeMethod(
        'decryptStringByPublicKey', {"string": string, "publicKey": publicKey});
  }

  /// 私钥加密
  static Future<String> encryptStringByPrivateKey(
      String string, String privateKey) async {
    return await _channel.invokeMethod('encryptStringByPrivateKey',
        {"string": string, "privateKey": privateKey});
  }

  /// 私钥解密
  static Future<String> decryptStringByPrivateKey(
      String string, String privateKey) async {
    return await _channel.invokeMethod('decryptStringByPrivateKey',
        {"string": string, "privateKey": privateKey});
  }
}
