import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failuers.dart';
import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/shop_status_usecase.dart';

part 'shopstatus_event.dart';
part 'shopstatus_state.dart';

class ShopstatusBloc extends Bloc<ShopstatusEvent, ShopstatusState> {
  ShopstatusBloc(ShopStatus shopStatus) : super(ShopstatusStateInitial()) {
    on<ShopstatusEvent>((event, emit) async {
      emit(ShopstatusStateLoading());
      Either<Failure, bool> variableName = await shopStatus(data: ShopStatusParams(branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!,methode: CALLMehode.get));
      if(event is ShopstatusUpdate){
        bool status = false;
        variableName.forEach((r) => status = r);
        variableName = await shopStatus(data: ShopStatusParams(branch: sl<SharedPreferences>().getString(Prefrence.BRANCH)!,methode: CALLMehode.set,status: status?"0":"1"));
        variableName.fold((l) => emit(ShopstatusStateError(mapFailureToMessage(l))), (r) {
          print("shpo status result:$r}");
          emit(ShopstatusStateSucsess<bool>(r));
        });
      }else{
        variableName.fold((l) => emit(ShopstatusStateError(mapFailureToMessage(l))), (r) {
          print("shpo status result:$r}");
          emit(ShopstatusStateSucsess<bool>(r));
        });
      }

      // TODO: implement event handler
    });
  }
}