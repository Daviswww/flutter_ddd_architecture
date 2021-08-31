import 'package:auto_route/auto_route.dart';
import 'package:stunning_tribble/presentation/screens/home/home_screen.dart';
import 'package:stunning_tribble/presentation/screens/login/login_screen.dart';
import 'package:stunning_tribble/presentation/screens/splash/splash_screen.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    CustomRoute(
      page: HomeScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: LoginScreen,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ],
)
class $AppRouter {}
