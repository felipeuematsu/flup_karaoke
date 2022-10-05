import 'dart:io';

import 'package:karaoke_request_client/util/ip_util/ip_util.dart';

class IpUtilImpl extends IpUtil {
  @override
  Future<String> getHost() async {
    final data = await NetworkInterface.list();
    final addresses = data.expand((element) => element.addresses).where((element) => element.type == InternetAddressType.IPv4 && element.host.contains('192')).toList();
    print(addresses);
    try {
      final ip = addresses.first.address;
      if (addresses.isEmpty) {
        return "localhost";
      }
      return ip;
    } catch (e) {
      return "localhost";
    }
  }

}