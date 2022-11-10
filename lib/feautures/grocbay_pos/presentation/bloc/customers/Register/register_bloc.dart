import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failuers.dart';
import '../../../../domain/entities/create-profile_model.dart';
import '../../../../domain/usecases/create-profile_usecase.dart';
import '../../../../domain/usecases/user_email_exist_usercase.dart';
import '../../../../domain/usecases/user_mobile_exist_usercase.dart';


part 'register_event.dart';
part 'register_state.dart';



class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  CustomerRegisterUsecase customerRegisterUsecase;
  CheckEmailUsecase checkEmailUsecase;
  CheckMobileUsecase checkMobileUsecase;

  RegisterBloc({required this.customerRegisterUsecase, required this.checkEmailUsecase, required this.checkMobileUsecase}) : super(RegisterInitial()) {
    // on<OnRegister>((event, emit) async{
    //   emit(RegisterLoading());
    //   final mobilecheckresult = await checkMobileUsecase(data:MobileCheckParams(mobileNumber: event.mobileNo, branch:event.branch)).then((mobilecheckresult) =>
    //       mobilecheckresult.forEach((r) {
    //         if(r.type=="new") {
    //           debugPrint("new number");
    //           checkEmailUsecase(data:EmailCheckParams(email: event.email, branch:event.branch)).then((emailcheckresult) => emailcheckresult.forEach((r) {
    //             if(r.type=="new"){
    //               debugPrint("new email");
    //               customerRegisterUsecase(data: CustomerRegisterParam(username: event.username, branch: event.branch, mobileNo: event.mobileNo, email: event.email, tokenId: event.tokenId, device: event.device, path: event.path, referralid: event.referralid, sex: event.sex)).then((value) =>  value.fold((l) => emit(RegisterError(mapFailureToMessage(l))), (r) => emit(RegisterSucsess(r))));
    //             }
    //             else{
    //               emit(RegisterError("Email Already Exists"));
    //             }
    //           }));
    //         } else {
    //           debugPrint("old");
    //           emit(RegisterError("Mobile Number Already Exists"));
    //         }
    //       }));
    //
    //
    //
    //   // TODO: implement event handler
    // });

    // on <OnRegister>((event, emit) async{
    //    emit(RegisterLoading());
    //    OnMobileCheck(event.mobileNo,event.branch);
    //
    //    if(event is OnMobileCheck){
    //      final mobilecheckresult = await checkMobileUsecase(data:MobileCheckParams(mobileNumber: event.mobileNo, branch:event.branch))
    //          .then((mobilecheckresult) =>
    //          mobilecheckresult.forEach((r) async{
    //            if(r.type=="new") {
    //              print("new number");
    //              OnEmailCheck(event.email,event.branch);
    //
    //            } else {
    //              print("old");
    //              emit(RegisterError("Mobile Number Already Exists"));
    //            }
    //          }));
    //    }
    //    else if(event is OnEmailCheck){
    //    final emailcheckresult = await  checkEmailUsecase(data:EmailCheckParams(email: event.email, branch:event.branch)).then((emailcheckresult) => emailcheckresult.forEach((r) {
    //        if(r.type=="new"){
    //          print("new email");
    //          OnRegister( event.username, event.branch,event.mobileNo,  event.email, event.tokenId, event.device,  event.path,  event.referralid, event.sex);
    //
    //        }
    //        else{
    //          emit(RegisterError("Email Already Exists"));
    //        }
    //      }));
    //    }
    //    else if(event is OnRegister){
    //      OnMobileCheck(event.mobileNo,event.branch);
    //      final registerresult = await customerRegisterUsecase(data: CustomerRegisterParam(
    //          username: event.username, branch: event.branch, mobileNo: event.mobileNo, email: event.email, tokenId: event.tokenId, device: event.device, path: event.path, referralid: event.referralid, sex: event.sex))
    //          .then((value) =>  value.fold((l) => emit(RegisterError(mapFailureToMessage(l))), (r) => emit(RegisterSucsess(r))));
    //    }
    //
    //
    //
    //
    //
    //
    //   // TODO: implement event handler
    // });
    on<OnRegister>((event, emit) async{
      bool isnewuser = false;
      emit(RegisterLoading());
      final mobilecheckresult =  await checkMobileUsecase(data:MobileCheckParams(mobileNumber: event.mobileNo, branch:event.branch));
      final emailcheckresult =    await checkEmailUsecase(data:EmailCheckParams(email: event.email, branch:event.branch));

      mobilecheckresult.forEach((r) {
        if(r.type=="new") {
          print("new number");
          if(event.email !="") {
            emailcheckresult.forEach((r) {
              if(r.type=="new"){
                print("new email");
                isnewuser = true;
}

              else{
                emit(RegisterError("Email Already Exists"));
              }
            });
          }else{
            isnewuser = true;
          }
        } else {
          print("old");
          emit(RegisterError("Mobile Number Already Exists"));
        }
      });
      if(isnewuser == true) {
        final value = await customerRegisterUsecase(data: CustomerRegisterParam(username: event.username, branch: event.branch, mobileNo: event.mobileNo, email: event.email, tokenId: event.tokenId, device: event.device, path: event.path, referralid: event.referralid, sex: event.sex));
        value.fold((l) => emit(RegisterError(mapFailureToMessage(l))), (r) => {
          emit(RegisterSucsess<CustomerRegister>(r))
        });
      }
      // TODO: implement event handler
    });
  }
}