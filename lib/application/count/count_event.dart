part of 'count_bloc.dart';

abstract class CountEvent extends Equatable {
  const CountEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends CountEvent {
  final int count;

  const IncrementEvent(this.count);

  @override
  List<Object> get props => [count];
}
