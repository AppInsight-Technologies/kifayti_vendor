import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/delivery_list_model.dart';
import '../repositorie/repository_provider.dart';

class deliveryListUsecase extends UseCase<List<DeliveryListModel>,deliveryListParms>{
  DependencyRepostProvider repo ;
  deliveryListUsecase(this.repo);

  @override
  Future<Either<Failure, List<DeliveryListModel>>> call({deliveryListParms? data}) async{
    // TODO: implement call
    List<DeliveryListModel> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("get-delivery-boys-list"),methed: Methed.Post,data: {"branch":data!.branch}));

   // value.map((r) => list.add(DeliveryListModel.fromJson(r['data'])));
    value.map((r) => r['data'].forEach((v){
      list.add(DeliveryListModel.fromJson(v));
    }));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class deliveryListParms{
  late String branch;

  deliveryListParms({required this.branch,});
}