# Day18 Environment
環境設定可以使開發的時候很方便的切換設定，通常會有開發、測試和產品三個狀態，每一個狀態中的參數將會對應不同狀態而不同，而我們可以預先設定好檔案，當重新載入時就可以切換狀態。

## 設置參數
在專案層中創建一個設置參數的`json`檔案，並在`pubspec.yaml`中設定`assets`的資料夾路徑。
```yaml
  assets:
    - assets/config/
```
![](https://i.imgur.com/iCRwhRR.png)


## 環境設定
設定每個狀態的名稱，在開發時可以切換，而且還可以避免打錯字的問題。
```dart
class Environment {
  /// name of the environment
  final String name;

  /// default constructor
  const Environment(this.name);

  /// preset of common env name 'dev'
  static const String dev = 'development';

  /// preset of common env name 'prod'
  static const String prod = 'production';

  /// preset of common env name 'test'
  static const String test = 'testing';
}
```
讀取剛剛設定好的參數檔案，而參數則會根據不同的`Environment`來獲取。

```dart
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'config_model.dart';

class ConfigReader {
  static ConfigModel _config =
      ConfigModel(API_HOST: "API_HOST", DEBUG: false, TESTING: false);

  static Future<void> initializeApp(String? env) async {
    env = env ?? "development";
    String configString = await rootBundle.loadString('assets/config/env.json');

    final jsonMap = json.decode(configString);
    _config = ConfigModel.fromMap(jsonMap[env]);
  }

  static ConfigModel config() {
    return _config;
  }
}

```
調用`WidgetsFlutterBinding.ensureInitialized()`，來實現初始元件的綁定，接著就可以使用環境設定了。

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.prod);
}
```

你可以試著切換不同的Environment，然後按下重新啟動就可以看到Debug繃帶的變化了。

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
```