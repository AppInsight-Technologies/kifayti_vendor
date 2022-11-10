import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/getRestaraunt.dart';
import '../entities/search_user_modle.dart';
import '../repositorie/repository_provider.dart';

class SearchUserUsecase extends UseCase< List<SearchUser>,UsersearchData> {
  DependencyRepostProvider repo;

  SearchUserUsecase({required this.repo});
  @override
  Future<Either<Failure,  List<SearchUser>>> call({UsersearchData? data}) async{
    // TODO: implement call
    List<SearchUser> list=[];
    final value = await repo.getRequest(Params(uri: Uri.parse("pos-search-user"),methed: Methed.Post,data: {"query":data!.query, "branch":sl<SharedPreferences>().getString(Prefrence.BRANCH)}));
    value.map((r) => r['data'].forEach((v){
      list.add(SearchUser.fromJson(v));
    }));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( list)));
  }
}
class UsersearchData {
  final String query;
  UsersearchData(this.query);
}