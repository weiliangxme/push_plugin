import 'package:flutter_test/flutter_test.dart';
import 'package:push_plugin/push_plugin.dart';
import 'package:push_plugin/push_plugin_platform_interface.dart';
import 'package:push_plugin/push_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPushPluginPlatform
    with MockPlatformInterfaceMixin
    implements PushPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PushPluginPlatform initialPlatform = PushPluginPlatform.instance;

  test('$MethodChannelPushPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPushPlugin>());
  });

  test('getPlatformVersion', () async {
    PushPlugin pushPlugin = PushPlugin();
    MockPushPluginPlatform fakePlatform = MockPushPluginPlatform();
    PushPluginPlatform.instance = fakePlatform;

    expect(await pushPlugin.getPlatformVersion(), '42');
  });
}
