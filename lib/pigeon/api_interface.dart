// api_interface.dart

import 'package:pigeon/pigeon.dart';

// Flutter 调用Native的接口定义，需要Native端实现定义的接口
@HostApi()
abstract class NativeApi {
  String getPlatformVersion();
}

// 原生调用 Flutter的接口定义，需要futter端实现定义的接口
@FlutterApi()
class FlutterApi {
  void sessionInvalid();
}
