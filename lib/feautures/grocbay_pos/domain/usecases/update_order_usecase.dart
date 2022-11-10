import 'package:dartz/dartz.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/update_order_model.dart';
import '../repositorie/repository_provider.dart';

class GetUpdateOrderUsecase extends UseCase<List<UpdateOrderModel>,UpdateOrderParms>{
  DependencyRepostProvider repo ;
  GetUpdateOrderUsecase(this.repo);

  @override
  Future<Either<Failure, List<UpdateOrderModel>>> call({UpdateOrderParms? data}) async{
    // TODO: implement call
    List<UpdateOrderModel> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("v2/view-customer-order-details/${data!.Oid}"),methed: Methed.Get,data: {'':''}));
    value.map((r) => list.add(UpdateOrderModel.fromJson(r['data'])));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class UpdateOrderParms{
  late String Oid;

  UpdateOrderParms({required this.Oid,});
}