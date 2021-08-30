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
