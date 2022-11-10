import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/fetch_category_product.dart';
import '../entities/getRestaraunt.dart';
import '../entities/search_user_modle.dart';
import '../repositorie/repository_provider.dart';

class SearchProductUsecase extends UseCase< List<FetchCategoryProduct>,ProductsearchData> {
  DependencyRepostProvider repo;

  SearchProductUsecase({required this.repo});
  @override
  Future<Either<Failure,  List<FetchCategoryProduct>>> call({ProductsearchData? data}) async{
    // TODO: implement call
    List<FetchCategoryProduct> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("v3/restaurant/search-items-by-cart"),methed: Methed.Post,data: {
      "apiKey":sl<SharedPreferences>().getString(Prefrence.BRANCH),
      "item_name":data!.query,
      "branch":sl<SharedPreferences>().getString(Prefrence.BRANCH),
      "language_id":sl<SharedPreferences>().getString("Languageid"),
    }));
    value.map((r) => r['data'].forEach((v){
      list.add(FetchCategoryProduct.fromJson(v));
    }));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }
}
class ProductsearchData {
  final String query;
  ProductsearchData(this.query);
}