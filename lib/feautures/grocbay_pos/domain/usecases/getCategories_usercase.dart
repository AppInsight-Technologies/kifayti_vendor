import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';


import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/getCategories.dart';
import '../repositorie/repository_provider.dart';

class GetCategoriesUsecase extends UseCase<List<GetCategories>,CategoryParams>{
  DependencyRepostProvider repo ;
  GetCategoriesUsecase(this.repo);

  @override
  Future<Either<Failure, List<GetCategories>>> call({CategoryParams? data}) async{
    // TODO: implement call
    List<GetCategories> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("get-product-category/list"),methed: Methed.Post,data: {"branch":sl<SharedPreferences>().getString(Prefrence.BRANCH),}));
    value.map((r) => r['data'].forEach((v){
      list.add(GetCategories.fromJson(v));
    }));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class CategoryParams{
  late String branch;
  CategoryParams({required this.branch,});
}