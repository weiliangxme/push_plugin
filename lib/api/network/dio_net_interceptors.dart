

import 'package:dio/dio.dart';
import 'package:push_plugin/utils/constants.dart';
import 'package:push_plugin/utils/rsa_utils.dart';
import '../../api/api_path.dart';


const String USER_ID = "userId";
const String APP_ID = "appId";
const String TIMESTAMP = "timestamp";
const String SIGN = "sign";

class NetInterceptor {
  static InterceptorsWrapper dioInterceptors() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        options.headers[USER_ID] = Constants.uid;
        options.headers[APP_ID] = Constants.appId;
        options.headers[TIMESTAMP] = timestamp;
        var sign = await RSAUtil.encrypt({TIMESTAMP:timestamp}, RSAUtil.PRIVATE_KEY);
        // options.headers[SIGN] = "TsMD+1vvyb6eZvoZjwAOLlOKYPtAz7DcjeeEiceH7sr/GSl8QVOnfd/vis86s9+c6PowepMR2aLMKPY5zKHbzS9mSxfYbKdy07bXVSK6F4+0OJ+nQGqVRjL/bxH8myy0Yc5mAZd1xdURtzJQLz1NsDwyU6lDSWqgK3eIm0Uh4KTtgw0kz0SJmxrpVxv2Crf8EFyTQ3h9JDd+2f4hKvAq7wJaiTgLTG5moGjMApdfCRtDfd0dMxjsYijdxlgwGUqUrL3r86THRPjNrrn6dRY6EdLFyVS4I0mupLRM5mWYlKWAdyuqdVH5VRHScooBZXIltbLwXnxn+BhvcuYq4xMLKQ==";
        options.headers[SIGN] = sign;
        options.baseUrl = ApiPath.pushUrl;
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
    );
  }
}





