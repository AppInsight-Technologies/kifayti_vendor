import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import '../..//core/usecases/usecase.dart';

import '../../../../../core/error/failuers.dart';
import '../../../domain/entities/get_profile_modle.dart';
import '../../../domain/repositorie/repository_provider.dart';
import '../../../domain/usecases/get_userprofile_usercase.dart';
import '../../../domain/usecases/usersearch_usecase.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';



class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  GetProfileCustomerUcase profileUserUsecase;

  UserProfileBloc({required this.profileUserUsecase}) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) async {
      if(event is ClearCustomerData){
        final  result =  await profileUserUsecase(data: CustomerProfileParam(u_id: event.apiKey, method: DB.REMOVE));
        result.fold((l) => emit(UserProfileError(mapFailureToMessage(l))), (r) => emit(UserProfileSucsess(r)));
      }
      else if(event is OnUserProfile){
        emit(UserProfileLoading());
        final  result =  await profileUserUsecase(data: CustomerProfileParam(u_id: event.apiKey, method: DB.GET));
        result.fold((l) => emit(UserProfileError(mapFailureToMessage(l))), (r) => emit(UserProfileSucsess(r)));
      }
     // TODO: implement event handler
    });
  }
}