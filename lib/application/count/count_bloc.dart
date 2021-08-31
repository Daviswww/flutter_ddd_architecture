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
