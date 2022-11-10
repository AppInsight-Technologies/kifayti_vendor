import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failuers.dart';

abstract class UseCase<type,Params>{
  Future<Either<Failure, type>> call({Params data});
}
class NoPrams extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Param extends Equatable{
  Map<String,dynamic> data;
  Param( this.data,);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
enum Methed {
  Get,Post,PostJson,
}