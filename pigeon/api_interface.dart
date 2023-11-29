// api_interface.dart

import 'package:pigeon/pigeon.dart';

// Flutter 调用Native的接口定义，需要Native端实现定义的接口
@HostApi()
abstract class NativeApiInterface {
  String getPlatformVersion();
}

// 原生调用 Flutter的接口定义，需要futter端实现定义的接口
@FlutterApi()
abstract class FlutterApiInterface {
  void sessionInvalid();
}
