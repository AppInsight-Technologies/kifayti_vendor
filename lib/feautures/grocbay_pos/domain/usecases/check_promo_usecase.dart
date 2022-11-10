import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/Fetch_category.dart';
import '../entities/check_promo_model.dart';
import '../entities/get_loyalty_model.dart';
import '../repositorie/repository_provider.dart';

class CheckPromoUsecase extends UseCase<CheckPromo,PromoParams>{
  DependencyRepostProvider repo ;
  CheckPromoUsecase({required this.repo});

  @override
  Future<Either<Failure, CheckPromo>> call({PromoParams? data}) async{
    // TODO: implement call

    final value = await repo.getRequest(Params(uri: Uri.parse("check-promocode"),methed: Methed.Post,data: {"promocode":data!.promocode, "items":data.items, "user":data.user, "total":data.total, "delivery":data.delivery, "branch":data.branch}));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( CheckPromo.fromJson(r))));



  }

}
class PromoParams{
  late String promocode;
  late String items;
  late String user;
  late String total;
  late String delivery;
  late String branch;

  PromoParams({required this.promocode, required this.items, required this.user, required this.total, required this.delivery,  required this.branch});
}