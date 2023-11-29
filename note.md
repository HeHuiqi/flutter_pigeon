重新生成项目各端项目
```
rm -rf ios android
flutter create . -i objc -a java

```


iOS项目引入Flutter后，安装Debug包，打开Flutter界面会出现

"In iOS 14+, debug mode Flutter apps can only be launched from Flutter tooling, IDEs with Flutter plugins or from Xcode" 问题。
解决办法如下：
用  XCode  打开工程项目，在 Build Settings 的最下方找到 `User-Defined`，点击 + 按钮，添加一个键为 `FLUTTER_BUILD_MODE` ，`Debug`设置`Profile`模式，`Profile`设置`Profile`模式，`Release`设置`Release` 模式。
