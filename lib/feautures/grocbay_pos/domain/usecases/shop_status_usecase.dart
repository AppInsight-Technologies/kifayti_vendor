import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_loyalty_model.dart';
import '../repositorie/repository_provider.dart';

class ShopStatus extends UseCase<bool,ShopStatusParams>{
  DependencyRepostProvider repo ;
  ShopStatus({required this.repo});

  @override
  Future<Either<Failure, bool>> call({ShopStatusParams? data}) async{
    // TODO: implement call
    final value = await repo.getRequest(Params(uri: Uri.parse(data!.methode == CALLMehode.get?"get-restaurant-status":"update-restaurant-status"),methed: Methed.Post,data: {"id":data.branch,"status":data.status??"",}));
    return  Future.value(value.fold((l) =>Left(l), (r) => Right(r["data"] == "1")));
  }

}
class ShopStatusParams{
  late CALLMehode methode;
  late String branch;
  String? status;
  ShopStatusParams({required this.methode, required this.branch,this.status});
}
enum CALLMehode{
  get,set
}