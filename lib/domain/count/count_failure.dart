import 'package:equatable/equatable.dart';

class CountAddFailure extends Equatable {
  final String message;

  CountAddFailure({required this.message});

  @override
  List<Object> get props => [message];
}
