import 'package:dartz/dartz.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/update_order_model.dart';
import '../repositorie/repository_provider.dart';

class UpdateOrderStatusUsecase extends UseCase<bool,UpdateOrderStatusParms>{
  DependencyRepostProvider repo ;
  UpdateOrderStatusUsecase(this.repo);

  @override
  Future<Either<Failure, bool>> call({UpdateOrderStatusParms? data}) async{
    // TODO: implement call
  //  List<UpdateOrderModel> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("update-order-status"),methed: Methed.Post,data: {
      "branch":data!.branch,
      "orderid": data.orderid,
      "orderStatus":data.orderStatus,
      "picker":data.picker,
      "delivery":data.delivery
    }));

    value.map((r) => true);
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( true)));
  }

}
class UpdateOrderStatusParms{
 String branch;
 String orderid;
 String orderStatus;
 String picker;
 String delivery;
  UpdateOrderStatusParms({required this.branch, required this.orderid,required this.orderStatus,required this.picker,required this.delivery});
}