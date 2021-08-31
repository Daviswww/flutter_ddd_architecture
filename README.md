
# Day28 Application Click Game

## Count：Event

按下螢幕時IncrementEvent事件觸發並把數字傳進來。

```dart
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

```

## Count：State
將計數器切成三個階段，初始數字、計數成功和計數失敗，成功的時候就會回傳加一的結果。

```dart
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

```
## Count：Bloc
IncrementEvent事件觸發時把數字傳進來加一然後回傳加一結果。

```dart
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stunning_tribble/infrastructure/count/count_repository.dart';

part 'count_event.dart';
part 'count_state.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  CountRepository _countRepository;
  CountBloc({required CountRepository countRepository})
      : _countRepository = countRepository,
        super(CountInitial());

  @override
  Stream<CountState> mapEventToState(
    CountEvent event,
  ) async* {
    if (event is IncrementEvent) {
      yield* _mapIncrementToState(event.count);
    }
  }

  Stream<CountState> _mapIncrementToState(int _count) async* {
    final increment = await _countRepository.increment(_count);
    yield* increment.fold(
      (countFailure) async* {
        log("$countFailure");
        yield CountFailure();
      },
      (count) async* {
        yield CountSuccess(count);
      },
    );
  }
}

```