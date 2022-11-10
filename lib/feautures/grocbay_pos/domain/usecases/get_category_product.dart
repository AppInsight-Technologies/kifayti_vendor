

import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/fetch_category_product.dart';
import '../repositorie/repository_provider.dart';

class GetCategoryProduct extends UseCase<List<FetchCategoryProduct>,CatProductParms>{
  DependencyRepostProvider repo ;
  GetCategoryProduct(this.repo);

  @override
  Future<Either<Failure, List<FetchCategoryProduct>>> call({CatProductParms? data}) async{
    // TODO: implement call
    List<FetchCategoryProduct> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("v3/restaurant/get-menuitem-by-cart"),methed: Methed.Post,data: {
      "id":data!.id,
      "start":data.start,
      "end":data.end,
      "branch":sl<SharedPreferences>().getString(Prefrence.BRANCH),
       "branchtype":"4",
      "language_id":sl<SharedPreferences>().getString("Languageid"),
      "type":data.type}));
    value.map((r) => r['data'].forEach((v){
      list.add(FetchCategoryProduct.fromJson(v));
    }));

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }

}
class CatProductParms{
  late String id;
  late String start;
  late String end;
  late String branch;
  late String language_id;
  late int type;
  CatProductParms({required this.id, required this.start, required this.end, required this.branch, required this.language_id, required this.type});
}