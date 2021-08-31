import 'package:equatable/equatable.dart';

class CountFailure extends Equatable {
  final String message;

  CountFailure({required this.message});

  @override
  List<Object> get props => [message];
}
