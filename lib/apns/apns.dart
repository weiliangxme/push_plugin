import 'package:push_plugin/apns/src/apns_connector.dart';

export 'package:push_plugin/apns/src/connector.dart';
export 'package:push_plugin/apns/src/apns_connector.dart';

/// Creates either APNS or Firebase connector to manage the push notification registration.
PushConnector createPushConnector() {
    return ApnsPushConnector();
}
