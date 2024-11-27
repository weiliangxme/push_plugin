import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'push_plugin_method_channel.dart';

abstract class PushPluginPlatform extends PlatformInterface {
  /// Constructs a PushPluginPlatform.
  PushPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PushPluginPlatform _instance = MethodChannelPushPlugin();

  /// The default instance of [PushPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPushPlugin].
  static PushPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PushPluginPlatform] when
  /// they register themselves.
  static set instance(PushPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
