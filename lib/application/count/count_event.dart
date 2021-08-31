part of 'count_bloc.dart';

abstract class CountEvent extends Equatable {
  const CountEvent();

  @override
  List<Object> get props => [];
}

class CountIncrementEvent extends CountEvent {
  final int count;

  const CountIncrementEvent(this.count);

  @override
  List<Object> get props => [count];
}
