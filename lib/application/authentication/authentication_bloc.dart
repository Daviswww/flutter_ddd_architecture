import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) async {
      log("AppStarted");
      final isSignedIn = await _authRepository.isSignedIn();
      await isSignedIn.fold(
        (failure) async {
          log("$failure");
          emit(Unauthenticated());
        },
        (isSignedInSuccess) async {
          log("isSignedInSuccess");
          await _mapLoggedInToState(emit);
        },
      );
    });

    on<LoggedIn>((event, emit) async {
      await _mapLoggedInToState(emit);
    });

    on<LoggedOut>((event, emit) async {
      await _mapLoggedOutToState(emit);
    });
  }

  Future<void> _mapAppStartedToState(Emitter<AuthenticationState> emit) async {
    final isSignedIn = await _authRepository.isSignedIn();
    await isSignedIn.fold(
      (failure) async {
        log("$failure");
        emit(Unauthenticated());
      },
      (isSignedInSuccess) async {
        log("isSignedInSuccess");
        await _mapLoggedInToState(emit);
      },
    );
  }

  Future<void> _mapLoggedInToState(Emitter<AuthenticationState> emit) async {
    final user = await _authRepository.getUser();
    await user.fold(
      (failure) async {
        log("$failure");
        emit(Unauthenticated());
      },
      (user) async {
        emit(Authenticated(user.displayName.toString()));
      },
    );
  }

  Future<void> _mapLoggedOutToState(Emitter<AuthenticationState> emit) async {
    final signOut = await _authRepository.signOut();
    await signOut.fold(
      (failure) async {
        log("$failure");
        emit(Unauthenticated());
      },
      (success) async {
        emit(Unauthenticated());
      },
    );
  }
}
