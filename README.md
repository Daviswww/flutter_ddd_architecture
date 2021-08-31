
# Day24 Application Login
這裡我們要將Google登入與介面做連接，所以又要使用Bloc了，老樣子按照著Event->State->Bloc的步驟建築起來吧。


## Login：Event
由於我只實作Google登入所以只有一個Google登入的事件，如果你有其他的可以繼續擴充。

```dart
part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGooglePressed extends LoginEvent {}

```

## Login：State
狀態分成三個登入成功、登入失敗和登入中，如果你是使用輸入帳密的登入話，還可以在裡面加一些參數來檢查是帳號沒輸入還是密碼沒輸入等等，這樣可以在UI上顯示錯誤訊息。

```dart
part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInStateInitial extends SignInState {}

class SignInStateLoading extends SignInState {}

class SignInStateFailure extends SignInState {}

class SignInStateSuccess extends SignInState {}

```


## Login：Bloc
登入然後檢查成功或失敗，這就是等等我們按鈕觸發事件時會執行的任務。

```dart
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  AuthRepository _userRepository;

  SignInBloc({
    required AuthRepository userRepository,
  })  : _userRepository = userRepository,
        super(SignInStateInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<SignInState> _mapLoginWithGooglePressedToState() async* {
    final user = await _userRepository.signInWithGoogle();
    yield* user.fold(
      (failure) async* {
        log("$failure");
        yield SignInStateFailure();
      },
      (success) async* {
        yield SignInStateSuccess();
      },
    );
  }
}

```