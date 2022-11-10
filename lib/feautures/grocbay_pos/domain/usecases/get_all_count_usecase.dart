import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/getAllCountModel.dart';
import '../repositorie/repository_provider.dart';

class GetAllCountUsecase extends UseCase<List<PosGetAllCount>,PosGetAllParms>{
  DependencyRepostProvider repo ;
  GetAllCountUsecase(this.repo);

  @override
  Future<Either<Failure, List<PosGetAllCount>>> call({PosGetAllParms? data}) async{
    // TODO: implement call
    List<PosGetAllCount> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("pos-get-all-count"),methed: Methed.Post,data: {"branch":data!.branch}));

    value.map((r) => r['data'].forEach((v){
      list.add(PosGetAllCount.fromJson(v));
    }));
    debugPrint("list....picker..."+list.toString());
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class PosGetAllParms{
  late String branch;

  PosGetAllParms({required this.branch,});
}