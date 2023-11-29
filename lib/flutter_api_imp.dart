import 'package:flutter/foundation.dart';

import 'flutter_bridge_api.dart';

class FlutterApiImp extends FlutterApiInterface {
  @override
  void sessionInvalid() {
    if (kDebugMode) {
      print("sessionInvalid call");
    }
  }
}
