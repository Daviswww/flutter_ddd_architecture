part of 'count_bloc.dart';

abstract class CountState extends Equatable {
  final int count;
  const CountState(this.count);

  @override
  List<Object> get props => [count];
}

class CountStateInitial extends CountState {
  CountStateInitial({required int count}) : super(0);

  @override
  List<Object> get props => [count];
}

class CountStateSuccess extends CountState {
  const CountStateSuccess({required int count}) : super(count);

  @override
  List<Object> get props => [count];
}

class CountStateFailure extends CountState {
  CountStateFailure(int count) : super(0);
}
