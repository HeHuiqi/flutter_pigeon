# flutter pigeon 入门

## 添加依赖
```yaml
# pubspec.yaml
dev_dependencies:
    pigeon: ^1.0.0
```


## 编写接口定义
```dart
// 在根目录创建pigeon 目录，存放所有的接口定义
// api_interface.dart

import 'package:pigeon/pigeon.dart';

// Flutter 调用Native的接口定义，需要Native端实现定义的接口
@HostApi()
abstract class NativeApi {
  String getPlatformVersion();
}

// 原生调用 Flutter的接口定义，需要futter端实现定义的接口
@FlutterApi()
abstract class FlutterApi {
  void sessionInvalid();
}
```
## 运行命令生成代码各端代码
```shell
# 代码文件名根据情况自己定义
flutter pub run pigeon \
 --input pigeon/api_interface.dart \
 --dart_out lib/FlutterBridgeApi.dart  \
 --objc_header_out ios/Runner/FlutterBridgeApi.h \
 --objc_source_out ios/Runner/FlutterBridgeApi.m \
 --objc_prefix FLT \
 --java_out android/app/src/main/java/io/flutter/plugins/FlutterBridgeApi.java \
 --java_package "io.flutter.plugins"

```

生成代码后开始实现接口，Native实现相关的Native接口，flutter实现flutter接口

## Native实现（iOS）
FlutterNativeApiImp.h
```Objc
//
//  FlutterNativeApiImp.h
//  Runner
//
//  Created by hbwb25942 on 2023/11/28.
//

#import <Foundation/Foundation.h>
#import "FlutterBridgeApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlutterNativeApiImp : NSObject<FLTNativeApi>

@end

NS_ASSUME_NONNULL_END

```

FlutterNativeApiImp.m
```Objc

//
//  FlutterNativeApiImp.m
//  Runner
//
//  Created by hbwb25942 on 2023/11/28.
//

#import "FlutterNativeApiImp.h"
#import <UIKit/UIKit.h>
@implementation FlutterNativeApiImp

// 实现接口
- (NSString *)getPlatformVersionWithError:(FlutterError * _Nullable __autoreleasing *)error {
    
    NSString *result = [NSString stringWithFormat: @"iOS %@",UIDevice.currentDevice.systemVersion];
    return result;

}
@end
```

## Native 注册实现和调用Flutter
```Objc
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "FlutterBridgeApi.h"
#import "FlutterNativeApiImp.h"

@interface AppDelegate ()

@property (nonatomic, strong) FLTFlutterApi *flutterApi;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"window:%@",self.window.rootViewController);
    FlutterViewController *rootVC = (FlutterViewController *)self.window.rootViewController;
    
    //注册Native实现
    FLTNativeApiSetup(rootVC.binaryMessenger, [FlutterNativeApiImp new]);
    self.flutterApi = [[FLTFlutterApi alloc] initWithBinaryMessenger:rootVC.binaryMessenger];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];

    //调用flutter方法示例
    //必须在主线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.flutterApi sessionInvalidWithCompletion:^(NSError * _Nullable error) {
            NSLog(@"sessionInvalidWithCompletion==%@",error.localizedDescription);
        }];
    });
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

```

## Flutter 实现

```dart
// FlutterApiImp.dart
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

```
## Flutter 注册实现和调用Native
```dart
// MyHomePage.dart
import 'package:flutter/material.dart';
import 'FlutterBridgeApi.dart';
import 'FlutterApiImp.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String platformVersion = '';
  //调用Native方法
  Future<String?> callNativePlatform() async {
    final api = NativeApi();
    final result = await api.getPlatformVersion();
    return result;
  }

  @override
  void initState() {
    //注册Flutter实现
    final apiManager = FlutterApiImp();
    FlutterApi.setup(apiManager);
    super.initState();
  }

  void getPlatformVersion() async {
    final res = await callNativePlatform();
    setState(() {
      platformVersion = res ?? 'no get version';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '点击按钮获取系统版本',
            ),
            Text(platformVersion),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getPlatformVersion,
        tooltip: '获取系统版本',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```


