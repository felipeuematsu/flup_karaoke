import 'package:karaoke_request_client/util/ip_util/ip_util.dart';

class IpUtilImpl extends IpUtil {
  @override
  Future<String> getHost() async {
    return Uri().host;
  }
}