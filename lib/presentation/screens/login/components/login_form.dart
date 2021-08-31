import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/application/sign_in/sign_in_bloc.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';
import 'package:stunning_tribble/presentation/screens/login/components/google_sign_in_button.dart';
import 'package:auto_route/auto_route.dart';

class LoginFrom extends StatelessWidget {
  const LoginFrom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInStateSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        if (state is SignInStateFailure) {
          // TODO: Display a snackbar
        }
      },
      child: Column(
        children: [
          GoogleSignInButton(),
        ],
      ),
    );
  }
}
