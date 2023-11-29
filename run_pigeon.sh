# run_pigeon.h

flutter pub run pigeon \
 --input pigeon/api_interface.dart \
 --dart_out lib/flutter_bridge_api.dart  \
 --objc_header_out ios/Runner/FlutterBridgeApi.h \
 --objc_source_out ios/Runner/FlutterBridgeApi.m \
 --objc_prefix FLT \
 --java_out android/app/src/main/java/io/flutter/plugins/FlutterBridgeApi.java \
 --java_package "io.flutter.plugins"