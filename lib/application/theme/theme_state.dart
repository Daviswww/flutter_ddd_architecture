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
