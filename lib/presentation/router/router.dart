import 'package:auto_route/auto_route.dart';
import 'package:stunning_tribble/presentation/screens/home/home_screen.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeScreen,
      initial: true,
    ),
  ],
)
class $AppRouter {}
