import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/getBrands.dart';
import '../repositorie/repository_provider.dart';

class GetBrandsUsecase extends UseCase<List<GetBrands>,BrandParams>{
  DependencyRepostProvider repo ;
  GetBrandsUsecase(this.repo);

  @override
  Future<Either<Failure, List<GetBrands>>> call({BrandParams? data}) async{
    // TODO: implement call
    List<GetBrands> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("restaurant/get-brands"),methed: Methed.Post,data: {"branch":sl<SharedPreferences>().getString(Prefrence.BRANCH),}));
    value.map((r) => r['data'].forEach((v){
      list.add(GetBrands.fromJson(v));
    }));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class BrandParams{
  late String branch;
  BrandParams({required this.branch,});
}