// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/home/home_screen.dart' as _i4;
import '../screens/login/login_screen.dart' as _i5;
import '../screens/splash/splash_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashScreen();
        }),
    HomeScreen.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.HomeScreen();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    LoginScreen.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.LoginScreen();
        },
        transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreen.name, path: '/'),
        _i1.RouteConfig(HomeScreen.name, path: '/home-screen'),
        _i1.RouteConfig(LoginScreen.name, path: '/login-screen')
      ];
}

class SplashScreen extends _i1.PageRouteInfo {
  const SplashScreen() : super(name, path: '/');

  static const String name = 'SplashScreen';
}

class HomeScreen extends _i1.PageRouteInfo {
  const HomeScreen() : super(name, path: '/home-screen');

  static const String name = 'HomeScreen';
}

class LoginScreen extends _i1.PageRouteInfo {
  const LoginScreen() : super(name, path: '/login-screen');

  static const String name = 'LoginScreen';
}
