import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stunning_tribble/application/authentication/authentication_bloc.dart';
import 'package:stunning_tribble/application/theme/theme_bloc.dart';
import 'package:stunning_tribble/config/config_reader.dart';
import 'package:stunning_tribble/config/environment.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';
import 'package:stunning_tribble/presentation/router/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initializeApp(Environment.dev);
  await Firebase.initializeApp();

  final AppRouter appRouter = AppRouter();
  final AuthRepository authRepository = AuthRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authRepository: authRepository,
          )..add(AppStarted()),
        ),
      ],
      child: MyApp(
        appRouter: appRouter,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter;

  const MyApp({
    Key? key,
    required AppRouter appRouter,
  })  : _appRouter = appRouter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: ConfigReader.config().DEBUG,
          title: 'Flutter Demo',
          theme: state.themeData,
          darkTheme: ThemeData(),
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          builder: (context, router) => router!,
        );
      },
    );
  }
}
