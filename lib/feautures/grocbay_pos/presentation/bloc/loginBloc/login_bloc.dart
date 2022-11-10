import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/getRestaraunt.dart';
import '../../../domain/repositorie/repository_provider.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginusecase;
  FetchUserUseCase fetchUserUseCase;

  LoginBloc({required this.loginusecase,required this.fetchUserUseCase}) : super(LoginInitial()) {
    on<OnCLickLogin>((event, emit) async {
      emit(LoginLoading());
     final  result =  await loginusecase(data: Param({"email":event.email,"password":event.password}));
        result.fold((l) => emit(LoginError(mapFailureToMessage(l))), (r) => emit(LoginSucsess<getUser>(r)));
      // TODO: implement event handler
    });

    on<OnCLickLogout>((event, emit) async {
      emit(LoginLoading());
      final  result =  await fetchUserUseCase(data: FetchUserParms(DB.REMOVE));
      result.fold((l) => emit(LoginError(mapFailureToMessage(l))), (r) => emit(LoginSucsess<getUser>(r)));
      // TODO: implement event handler
    });

    on<FetchUserData>((event, emit) async {
      emit(LoginLoading());
      final result = await fetchUserUseCase(data: FetchUserParms(DB.GET));
      result.fold((l) {
        print("error fetching user");
        emit(LoginError(mapFailureToMessage(l)));
      }, (r) => emit(LoginSucsess<getUser>(r)));
      // TODO: implement event handler
    });
  }
}
