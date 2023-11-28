import 'package:flutter/foundation.dart';

import 'FlutterBridgeApi.dart';

class FlutterApiImp extends FlutterApi {
  @override
  void sessionInvalid() {
    if (kDebugMode) {
      print("sessionInvalid call");
    }
  }
}
