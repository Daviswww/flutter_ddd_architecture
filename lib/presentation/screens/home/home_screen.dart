import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/application/count/count_bloc.dart';
import 'package:stunning_tribble/infrastructure/count/count_repository.dart';
import 'package:stunning_tribble/presentation/screens/home/components/count_button.dart';
import 'package:stunning_tribble/presentation/screens/home/components/sign_out_button.dart';
import 'package:stunning_tribble/presentation/screens/home/components/switch_mode_button.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.replaceRoute(LoginScreen());
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
              BlocProvider(
                create: (context) => CountBloc(
                  countRepository: CountRepository(),
                ),
                child: CountButton(),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: SignOutButton(),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: SwtichModeButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
