import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/application/sign_in/sign_in_bloc.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';
import 'package:stunning_tribble/presentation/screens/login/components/login_form.dart';
import 'package:auto_route/auto_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.replaceRoute(HomeScreen());
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 200,
                child: Text(
                  "Hello",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Positioned(
                top: 370,
                child: BlocProvider(
                  create: (context) =>
                      SignInBloc(authRepository: AuthRepository()),
                  child: LoginFrom(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
