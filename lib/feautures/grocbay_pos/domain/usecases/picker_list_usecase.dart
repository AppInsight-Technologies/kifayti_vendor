import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/delivery_list_model.dart';
import '../entities/picker_list_model.dart';
import '../repositorie/repository_provider.dart';

class pickerListUsecase extends UseCase<List<PickerListModel>,pickerListParms>{
  DependencyRepostProvider repo ;
  pickerListUsecase(this.repo);

  @override
  Future<Either<Failure, List<PickerListModel>>> call({pickerListParms? data}) async{
    // TODO: implement call
    List<PickerListModel> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("get-picker-list"),methed: Methed.Post,data: {"branch":data!.branch}));

    value.map((r) => r['data'].forEach((v){
      list.add(PickerListModel.fromJson(v));
    }));
    debugPrint("list....picker..."+list.toString());
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class pickerListParms{
  late String branch;

  pickerListParms({required this.branch,});
}