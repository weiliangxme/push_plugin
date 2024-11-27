#import "MzRsaPlugin.h"
#import "MZRSA.h"

@implementation MzRsaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"mz_rsa_plugin"
            binaryMessenger:[registrar messenger]];
  MzRsaPlugin* instance = [[MzRsaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"encryptStringByPublicKey" isEqualToString:call.method]) {
      result([MZRSA encryptString:call.arguments[@"string"] publicKey:call.arguments[@"publicKey"]]);
  } else if ([@"decryptStringByPublicKey" isEqualToString:call.method]) {
      result([MZRSA decryptString:call.arguments[@"string"] publicKey:call.arguments[@"publicKey"]]);
  } else if ([@"encryptStringByPrivateKey" isEqualToString:call.method]) {
      result([MZRSA encryptString:call.arguments[@"string"] privateKey:call.arguments[@"privateKey"]]);
  } else if ([@"decryptStringByPrivateKey" isEqualToString:call.method]) {
      result([MZRSA decryptString:call.arguments[@"string"] privateKey:call.arguments[@"privateKey"]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
