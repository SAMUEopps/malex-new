import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String msg = 'Server error']) : super(msg);
}

class CacheFailure extends Failure {
  const CacheFailure([String msg = 'Cache error']) : super(msg);
}