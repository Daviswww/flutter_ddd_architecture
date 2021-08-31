# Day20 Theme：Dark mode & Light mode
使用Theme可以定義整個應用的主題，也可以使用元件來定義應用程式特定部分的顏色和字體樣式，例如 AppBars、按鈕、設置背景顏色和字體樣式等。

```dart
MaterialApp(
  title: appName,
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    accentColor: Colors.accents,
  ),
  home: Home(),
);
```

## 套件

```yaml
bloc: ^7.1.0
flutter_bloc: ^7.1.0
equatable: ^2.0.3
```

## ThemeData：Dark mode & Light mode
在做主題切換前先來創建一個深色與淺色主題的顏色，利用上一篇day19的shared設定的顏色來做主題顏色。

```dart
import 'package:flutter/material.dart';
import 'package:stunning_tribble/shared/colors.dart';

class AppThemeData {
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: oil6Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil2Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    backgroundColor: oil2Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil5Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
```
## Bloc：Theme
完成主題配置後就可以來建造熟悉的Bloc，不熟的同學可以去看day13的教學。首先是事件，由於我會使用 switch 這個小部件切換深淺主題，這個部件會回傳現在的狀態是開還是關，所以下面我就把true和false直接傳進去。

```dart
part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  final bool isDark;
  const ThemeEvent(this.isDark);

  @override
  List<Object> get props => [];
}

class ThemeChange extends ThemeEvent {
  ThemeChange(bool isDark) : super(isDark);
}

```

傳進去以後呢我希望他回傳主題顏色和開關的狀態，這樣我們等等使用 BlocBuilder 的時候就可以改變UI和開關狀態。

```dart
part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDark;
  const ThemeState({
    required this.isDark,
    required this.themeData,
  });

  @override
  List<Object> get props => [themeData, isDark];
}
```

在Bloc中就按照著切換主題流程把它寫出來，當ThemeChange事件觸發時，把目前開關狀態傳入，然後判斷開關狀態切換主題。

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stunning_tribble/shared/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: AppThemeData.darkMode, isDark: true));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChange) {
      yield* _mapThemeChangeToState(event.isDark);
    }
  }

  Stream<ThemeState> _mapThemeChangeToState(bool _isDark) async* {
    if (_isDark) {
      yield ThemeState(themeData: AppThemeData.darkMode, isDark: true);
    } else {
      yield ThemeState(themeData: AppThemeData.lightMode, isDark: false);
    }
  }
}

```
## 切換深淺主題
首先創建剛剛寫好的ThemeBloc。

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.dev);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
```

接著利用BlocBuilder來查看themeData的狀態。

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
          title: 'Flutter Demo',
          theme: state.themeData,
          darkTheme: ThemeData(),
          home: HomeScreen(),
        );
      },
    );
  }
}
```

最後把我們的按鈕加入事件，你就可以切換主題囉！

```dart
class SwtichModeButton extends StatelessWidget {
  const SwtichModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
          inactiveThumbColor: Theme.of(context).primaryColorLight,
          activeColor: Theme.of(context).primaryColorDark,
          value: state.isDark,
          onChanged: (isDark) {
            BlocProvider.of<ThemeBloc>(context).add(ThemeChange(isDark));
          },
        );
      },
    );
  }
}

```

![](https://i.imgur.com/ijNj2rg.gif)

## Note
本次的主題切換順便幫大家複習一下Bloc的用法。
