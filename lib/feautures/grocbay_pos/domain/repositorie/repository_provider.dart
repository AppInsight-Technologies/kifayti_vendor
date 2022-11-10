import 'package:dartz/dartz.dart';


import '../../../../core/data/hive_db.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/modle_entities.dart';

abstract class DependencyRepostProvider<Entities>{
  Future<Either<Failure,Entities>> getRequest(Params param);
  Future<Either<Failure,Entities>> getLocalDBRequest(LDBParams param);
}
class Params{
   Uri uri;
   Map<String,dynamic>? data;
   Methed methed;

  Params({required this.uri, this.data, required this.methed});
}
class LDBParams{
   String key;
   Map<String,dynamic>? data;
   DB methed;
   DBTable table;

   LDBParams({required this.key, this.data, required this.methed,required this.table});
}
enum DB{
  GET,SET,UPDATE,REMOVE,CLEAR
}