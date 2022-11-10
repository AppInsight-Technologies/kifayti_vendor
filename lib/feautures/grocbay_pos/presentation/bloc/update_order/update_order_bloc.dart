
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/update_order_usecase.dart';

part 'update_order_event.dart';
part 'update_order_state.dart';


class UpdateOrderBloc extends Bloc<UpdateOrderEvent, UpdateOrderState> {
  GetUpdateOrderUsecase getUpdateOrder;

  UpdateOrderBloc({required this.getUpdateOrder}) : super(UpdateOrderInitial()) {
    on<OnUpdateOrderEvent>((event, emit) async{

      emit(UpdateOrderLoading());
      final updateOrderresult =  await getUpdateOrder(data:UpdateOrderParms(Oid: event.oId));
      updateOrderresult.fold((l) => emit(UpdateOrderError(mapFailureToMessage(l))), (r) => emit(UpdateOrderSucsess(r)));

      // TODO: implement event handler
    });
  }
}