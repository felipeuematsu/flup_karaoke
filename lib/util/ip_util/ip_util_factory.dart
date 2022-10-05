import 'package:karaoke_request_client/util/ip_util/ip_util.dart';

import 'ip_util_stub.dart'
if (dart.library.io) 'ip_util_io.dart'
if (dart.library.html) 'ip_util_web.dart';

class IpUtilFactory {
  static IpUtil getIpUtil() {
    return IpUtilImpl();
  }
}