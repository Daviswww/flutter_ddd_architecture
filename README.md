# Day25 Application Authentication
接著就是來驗證登入狀態，如果已經登入就跳轉到首頁否則就在登入畫面，看完我這句話就知道要使用Bloc了，只要是畫面與功能就要使用到Bloc。以上是一個基本的狀態你還可以檢查有沒有重複登入等...。

## Authentication：Event
狀態分成三個，開啟APP時檢查有沒有登入，如果沒有就跳轉到登入介面，最後就是登出按鈕觸發時使用的。
```dart
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

```

## Authentication：State
狀態可以分成兩個，未認證與認證，如果認證成功就切換到首頁否則就停留在登入畫面。

```dart
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}


class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class Unauthenticated extends AuthenticationState {}

```

## Authentication：Bloc
判斷三種狀態並分別做對應的工作，寫到這邊時大家應該都對這個架構感覺了吧，是不是覺得越來越美了呢。

```dart
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

```