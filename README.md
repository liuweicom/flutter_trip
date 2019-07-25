# flutter_trip

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
#开发过程中遇到的坑
1.编译失败
````
Manifest merger failed : Attribute application@appComponentFactory value=(android.support.v4.app.CoreComponentFactory) from [com.android.support:support-compat:28.0.0] AndroidManifest.xml:22:18-91
    is also present at [androidx.core:core:1.0.0] AndroidManifest.xml:22:18-86 value=(androidx.core.app.CoreComponentFactory).
    Suggestion: add 'tools:replace="android:appComponentFactory"' to <application> element at AndroidManifest.xml:36:5-364:19 to override.
````
根本问题是：
androidx 包冲突
如何查看哪个包中带有androidX
在Android项目下执行
````
gradlew :app:dependencies
````
app为你的工程名
结果
````
+--- project :flutter_webview_plugin
|    \--- androidx.appcompat:appcompat:1.0.0
|         +--- androidx.annotation:annotation:1.0.0
|         +--- androidx.core:core:1.0.0
|         |    +--- androidx.annotation:annotation:1.0.0
|         |    +--- androidx.collection:collection:1.0.0
|         |    |    \--- androidx.annotation:annotation:1.0.0
|         |    +--- androidx.lifecycle:lifecycle-runtime:2.0.0

````
可以看出是应为flutter_webview_plugin中带有Androidx导致的问题
如何解决：
1.手动升级到androidX或者使用选择工程右键→Refactor→Migrate to Androidx...
2.固定使用包的版本在不升级AndroidX之前的版本

报错之：
More than one file was found with OS independent path 'lib/x86/libflutter.so'

