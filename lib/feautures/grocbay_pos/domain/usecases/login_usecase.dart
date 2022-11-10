import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/hive_db.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../injection_container.dart';
import '../entities/getRestaraunt.dart';
import '../repositorie/repository_provider.dart';

class LoginUseCase extends UseCase<getUser,Param> {
  DependencyRepostProvider<Map<String,dynamic>> repo;

  LoginUseCase({required this.repo});
  @override
  Future<Either<Failure, getUser>> call({Param? data}) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO: implement call
    print("login");
    final value = await repo.getRequest(Params(uri: Uri.parse("pos-login"),methed: Methed.Post,data: {
      "email":((data!.props.first as Map<String,dynamic>)["email"]),
      "password":(data.props.first as Map<String,dynamic>)["password"],
      "tokenId":  prefs.getString("ftokenid")
    }));
    print("hjghjghjg");
    return  Future.value(value.fold((l) =>Left(l), (r) async{
     await repo.getLocalDBRequest(LDBParams(table: DBTable.UserProfile,key: "user",methed: DB.SET,data: r));
      final data = <getUser>[];
      if (r['data'] != null) {
        r['data'].forEach((v) { data.add(getUser.fromJson(v));});
      }
      return Right( data.first);
    }));
  }
}

class FetchUserUseCase extends UseCase<getUser,FetchUserParms> {
  DependencyRepostProvider<Map<String, dynamic>> repo;

  FetchUserUseCase({required this.repo});

  @override
  Future<Either<Failure, getUser>> call({FetchUserParms? data}) async{
    // TODO: implement call
    print("calling at...${data!.method} ${data.data}");
    final value = await repo.getLocalDBRequest(LDBParams(table: DBTable.UserProfile,key: "user",methed: data.method,));
    print("calling...");
    return  Future.value(value.fold((l) {
      print("has error: ${mapFailureToMessage(l)}");
      return Left(l);
    }, (r) async{
      print("user data: ${r['data'][0]}");
      // HiveDB<GetRestaraunt>(database: DBTable.UserProfile).add(key: "user",value: data.first);
      return Right( getUser.fromJson(r['data'][0]));
    }));
  }
}
class LoginData extends Param{
  final data;
  LoginData(this.data) : super(data);

}
class FetchUserParms {
  DB method;
  Map<String,dynamic>? data;
  FetchUserParms(this.method, [this.data]);
}