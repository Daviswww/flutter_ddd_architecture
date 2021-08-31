import 'package:equatable/equatable.dart';

abstract class AuthFailure extends Equatable {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class GoogleAuthServerFailure extends AuthFailure {
  GoogleAuthServerFailure({required String message}) : super(message: "");
}

class FirebaseAuthFailure extends AuthFailure {
  FirebaseAuthFailure({required String message}) : super(message: "");
}
