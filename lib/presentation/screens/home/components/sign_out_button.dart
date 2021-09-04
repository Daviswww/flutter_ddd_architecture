import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';

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
