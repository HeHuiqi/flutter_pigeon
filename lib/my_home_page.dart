import 'package:flutter/material.dart';
import 'flutter_bridge_api.dart';
import 'flutter_api_imp.dart';

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
    final api = NativeApiInterface();
    final result = await api.getPlatformVersion();
    return result;
  }

  @override
  void initState() {
    //注册Flutter实现
    final apiManager = FlutterApiImp();
    FlutterApiInterface.setup(apiManager);
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
