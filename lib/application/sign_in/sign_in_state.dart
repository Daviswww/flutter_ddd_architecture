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
