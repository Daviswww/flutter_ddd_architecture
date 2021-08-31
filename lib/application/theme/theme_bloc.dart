import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stunning_tribble/infrastructure/theme/theme.dart';

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
