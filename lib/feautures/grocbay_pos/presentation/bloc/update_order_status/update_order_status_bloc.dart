
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/update_order_status_usecase.dart';


part 'update_order_status_event.dart';
part 'update_order_status_state.dart';


class UpdateOrderStatusBloc extends Bloc<UpdateOrderStatusEvent, UpdateOrderStatusState> {
  UpdateOrderStatusUsecase getUpdateOrderStatus;

  UpdateOrderStatusBloc({required this.getUpdateOrderStatus}) : super(UpdateOrderStatusInitial()) {
    on<UpdateOrderStatusEvent>((event, emit) async{

      emit(UpdateOrderStatusLoading());
      if(event is AssainPicker){
        final updateOrderstatusresult =  await getUpdateOrderStatus(data:UpdateOrderStatusParms(branch: event.branch,orderid: event.orderid,orderStatus: event.orderStatus,picker: event.picker,delivery: ""));
        updateOrderstatusresult.fold((l) => emit(UpdateOrderStatusError(mapFailureToMessage(l))), (r) {
          print('order ststus sucsses: $r');
          emit(UpdateOrderStatusSucsess(r));
        });
      }else if(event is AssainDelevery){
        final updateOrderstatusresult =  await getUpdateOrderStatus(data:UpdateOrderStatusParms(branch: event.branch,orderid: event.orderid,orderStatus: event.orderStatus,picker: "",delivery: event.delivery));
        updateOrderstatusresult.fold((l) => emit(UpdateOrderStatusError(mapFailureToMessage(l))), (r) => emit(UpdateOrderStatusSucsess(r)));

      }else if(event is OrderReady){
        final updateOrderstatusresult =  await getUpdateOrderStatus(data:UpdateOrderStatusParms(branch: event.branch,orderid: event.orderid,orderStatus: event.orderStatus,picker: "",delivery: ""));
        updateOrderstatusresult.fold((l) => emit(UpdateOrderStatusError(mapFailureToMessage(l))), (r) => emit(UpdateOrderStatusSucsess(r)));

      }
      // TODO: implement event handler
    });
  }
}