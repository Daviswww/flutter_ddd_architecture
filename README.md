# Day26 Presentation Login & Splash Screen
今天就是把之前寫的一堆功能放到Screen裡面，由於是UI的部分所以程式碼會很長，有些地方我只會擷取片段，建議大家看完整程式碼。

## Splash Screen
把首頁的MultiBlocProvider加上AuthenticationBloc，並觸發事件AppStarted()來檢查是否有登入過。
main.dart
```dart
BlocProvider(
  create: (context) => AuthenticationBloc(
    authRepository: authRepository,
  )..add(AppStarted()),
),
```

把這個畫面設置成初始畫面，然後當事件觸發後BlocListener會監聽AuthenticationBloc現在的狀態進行頁面切換。

```dart
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.replaceRoute(LoginScreen());
        }
        if (state is Authenticated) {
          context.replaceRoute(HomeScreen());
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}

```

## Login Screen
在`LoginScreen`這邊一樣加一個`AuthenticationBloc`監聽器，檢查是否登入成功取得驗證。

```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.replaceRoute(HomeScreen());
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 200,
                child: Text(
                  "Hello",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Positioned(
                top: 370,
                child: BlocProvider(
                  create: (context) =>
                      SignInBloc(authRepository: AuthRepository()),
                  child: LoginFrom(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Login From
創建`SignInBloc`然後在`LoginForm`裡面寫一個`SignInBloc`的監聽器來檢查登入成功或失敗，如果登入成功的話就觸法`LoggedIn`的事件。

```dart
Positioned(
    top: 370,
    child: BlocProvider(
      create: (context) =>
          SignInBloc(authRepository: AuthRepository()),
      child: LoginFrom(),
    ),
),
```

```dart
class LoginFrom extends StatelessWidget {
  const LoginFrom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInStateSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        if (state is SignInStateFailure) {
          // TODO: Display a snackbar
        }
      },
      child: Column(
        children: [
          GoogleSignInButton(),
        ],
      ),
    );
  }
}
```

![](https://i.imgur.com/ZcRe5Cm.png)

## Home Screen
在首頁檢查驗證登入狀態，然後在登出按鈕新增LoggedOut事件。
```dart
return BlocListener<AuthenticationBloc, AuthenticationState>(
  listener: (context, state) {
    if (state is Unauthenticated) {
      context.replaceRoute(LoginScreen());
    }
  },
```

```dart
class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      },
      icon: Icon(
        Icons.sports_bar_rounded,
        color: Theme.of(context).shadowColor,
        size: 30,
      ),
    );
  }
}
```
![](https://i.imgur.com/kPjzTFj.png)
