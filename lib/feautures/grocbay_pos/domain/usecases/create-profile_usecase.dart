import 'package:dartz/dartz.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/create-profile_model.dart';
import '../entities/getRestaraunt.dart';
import '../entities/get_profile_modle.dart';
import '../repositorie/repository_provider.dart';

class CustomerRegisterUsecase extends UseCase<CustomerRegister,CustomerRegisterParam> {
  DependencyRepostProvider repo;

  CustomerRegisterUsecase({required this.repo});
  @override
  Future<Either<Failure, CustomerRegister>> call({CustomerRegisterParam? data}) async{
    CustomerRegister list;
    final value = await repo.getRequest(Params(uri: Uri.parse("v2/customer/register"),methed: Methed.Post,data: {"username":data!.username, "email":data.email, "branch":data.branch, "mobileNumber":data.mobileNo, "tokenId":data.tokenId, "device":data.device, "referralid":data.referralid, "path":data.path, "sex":data.sex}));
 print("passing data" +data.mobileNo + "........." +data.toString());
  value.forEach((r) {
    print("response"+r.toString());
  });

    return  Future.value(value.fold((l) =>Left(l), (r) =>Right(CustomerRegister.fromJson(r))));

    }

  }

class CustomerRegisterParam {
  final String username;
  final String email;
  final String branch;
  final String mobileNo;
  final String tokenId;
  final String device;
  final String referralid;
  final String path;
  final int sex;

  CustomerRegisterParam({required this.username,required this.email,required this.branch,required this.mobileNo,required this.tokenId,required this.device,required this.referralid,required this.path,required this.sex});

}