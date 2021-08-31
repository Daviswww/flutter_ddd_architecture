import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _userRepository;

  AuthenticationBloc({
    required AuthRepository userRepository,
  })  : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    yield* isSignedIn.fold(
      (failure) async* {
        log("$failure");
        yield Unauthenticated();
      },
      (isSignedInSuccess) async* {
        yield* _mapLoggedInToState();
      },
    );
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final user = await _userRepository.getUser();
    yield* user.fold(
      (failure) async* {
        log("$failure");
        yield Unauthenticated();
      },
      (user) async* {
        yield Authenticated(user.displayName.toString());
      },
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    final signOut = await _userRepository.signOut();
    yield* signOut.fold(
      (failure) async* {
        log("$failure");
        yield Unauthenticated();
      },
      (r) async* {
        yield Unauthenticated();
      },
    );
  }
}
