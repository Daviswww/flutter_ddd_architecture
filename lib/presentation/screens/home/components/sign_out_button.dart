import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.replaceRoute(LoginScreen());
        }
      },
      child: IconButton(
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        },
        icon: Icon(
          Icons.sports_bar_rounded,
          color: Theme.of(context).shadowColor,
          size: 30,
        ),
      ),
    );
  }
}
