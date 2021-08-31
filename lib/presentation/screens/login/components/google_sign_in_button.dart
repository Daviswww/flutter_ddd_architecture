import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/sign_in/sign_in_bloc.dart';
import 'package:stunning_tribble/shared/colors.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<SignInBloc>(context).add(
          SignInWithGooglePressed(),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 20,
        shadowColor: Theme.of(context).shadowColor,
        onPrimary: Theme.of(context).primaryColorDark,
        primary: Theme.of(context).primaryColor,
      ),
      icon: Icon(
        Icons.lens_blur_rounded,
        color: oil6Color,
      ),
      label: Text(
        "Sign in with Google",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: oil6Color,
        ),
      ),
    );
  }
}
