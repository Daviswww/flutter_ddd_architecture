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
        super(CountStateInitial(count: 0)) {
    on<CountIncrementEvent>((event, emit) => _mapIncrementToState(event.count));
  }

  // @override
  // Stream<CountState> mapEventToState(
  //   CountEvent event,
  // ) async* {
  //   if (event is CountIncrementEvent) {
  //     yield* _mapIncrementToState(event.count);
  //   }
  // }

  Future<void> _mapIncrementToState(int _count) async {
    final increment = await _countRepository.increment(_count);
    increment.fold(
      (countFailure) async* {
        log("$countFailure");
        yield CountStateFailure(0);
      },
      (count) async* {
        yield CountStateSuccess(count: count);
      },
    );
  }
}
