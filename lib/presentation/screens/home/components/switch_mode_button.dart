import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/theme/theme_bloc.dart';

class SwtichModeButton extends StatelessWidget {
  const SwtichModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
          activeTrackColor: Theme.of(context).primaryColorLight,
          activeColor: Theme.of(context).primaryColorDark,
          value: state.isDark,
          onChanged: (state) {
            BlocProvider.of<ThemeBloc>(context).add(ThemeChange(state));
          },
        );
      },
    );
  }
}
