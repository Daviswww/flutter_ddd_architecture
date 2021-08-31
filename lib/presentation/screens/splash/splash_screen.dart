import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';

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
