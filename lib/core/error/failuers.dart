import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
Failure([List properties = const <dynamic>[]]);
@override
// TODO: implement props
List<Object?> get props => [];
}
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
class ServerFailure extends Failure{
}
class CacheFailure   extends Failure{
}
String mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}