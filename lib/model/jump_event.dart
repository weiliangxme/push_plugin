
import 'package:push_plugin/model/push_click_model.dart';

enum JumpType{
  internalPage,
  inAppWebView,
  systemWebView,
}

class JumpEvent {
  final JumpType jumpType;
  final String? page;
  final String? url;
  final PushClickModel extra;

  JumpEvent({
    required this.jumpType,
    this.page,
    this.url,
    required this.extra,
  });
}