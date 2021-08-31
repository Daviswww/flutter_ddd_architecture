part of 'count_bloc.dart';

abstract class CountState extends Equatable {
  const CountState();

  @override
  List<Object> get props => [];
}

class CountInitial extends CountState {
  final int count = 0;

  @override
  List<Object> get props => [count];
}

class CountSuccess extends CountState {
  final int count;

  const CountSuccess(this.count);

  @override
  List<Object> get props => [count];
}

class CountFailure extends CountState {}
