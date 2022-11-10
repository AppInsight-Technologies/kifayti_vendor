import 'package:dartz/dartz.dart';

import '../error/failuers.dart';

class InputConverter{
  Either<Failure,int> toUnsignedInt(String? str){
   try{
     final int inte = int.parse(str!);
     if (inte<0) {
       throw FormatException();
     }
     return Right(inte);
   } on FormatException{
     return Left(InvalidInputFailure());
   }
  }
}
class InvalidInputFailure extends Failure{}