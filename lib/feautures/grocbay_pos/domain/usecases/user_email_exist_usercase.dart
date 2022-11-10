import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/Fetch_category.dart';
import '../entities/check_email_model.dart';
import '../entities/check_loyalty_model.dart';
import '../entities/get_loyalty_model.dart';
import '../repositorie/repository_provider.dart';

class CheckEmailUsecase extends UseCase<EmailCheck,EmailCheckParams>{
  DependencyRepostProvider repo ;
  CheckEmailUsecase({required this.repo});

  @override
  Future<Either<Failure, EmailCheck>> call({EmailCheckParams? data}) async{
    // TODO: implement call
    checkLoyalty list;
    final value = await repo.getRequest(Params(uri: Uri.parse("customer/email-check"),methed: Methed.Post,data: {"email":data!.email,"branch":data.branch}));


    return  Future.value(value.fold((l) =>Left(l), (r) =>Right(EmailCheck.fromJson(r))));
  }

}
class EmailCheckParams{
  late String email;
  late String branch;
  EmailCheckParams({required this.email, required this.branch});
}