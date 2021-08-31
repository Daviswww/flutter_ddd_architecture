abstract class CountRepositoryImp {
  /// Count model
  ///
  /// Increment one
  Future<int> increment(int count);
}

class CountRepository implements CountRepositoryImp {
  @override
  Future<int> increment(count) async {
    return ++count;
  }
}
