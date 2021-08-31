
# Day27 Infrastructure Click Game
寫到這邊時不知道大家都已經非常熟練了，這次我們要來做一個有趣的小遊戲，就是點一下螢幕數字就會加一，是不是很有趣呢？

## Repository & Domain
即便是一個小小的程式還是要照著流程走。

```dart
import 'package:equatable/equatable.dart';

class CountAddFailure extends Equatable {
  final String message;

  CountAddFailure({required this.message});

  @override
  List<Object> get props => [message];
}

```

```dart
import 'package:dartz/dartz.dart';
import 'package:stunning_tribble/domain/count/count_failure.dart';

abstract class CountRepositoryImp {
  /// Count model
  ///
  /// Increment one
  Future<Either<CountAddFailure, int>> increment(int count);
}

class CountRepository implements CountRepositoryImp {
  @override
  Future<Either<CountAddFailure, int>> increment(count) async {
    try {
      return right(++count);
    } catch (e) {
      return left(CountAddFailure(message: "$e"));
    }
  }
}
```


## Note:
應該滿有趣的吧～