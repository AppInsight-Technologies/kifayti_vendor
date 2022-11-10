import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/entities/pos_ordersearch_model.dart';
import '../../../domain/usecases/searchorderlist_usercase.dart';

part 'order_managment_event.dart';

part 'order_managment_state.dart';

class OrderManagmentBloc
    extends Bloc<OrderManagmentEvent, OrderManagmentState> {
  OrderManagmentBloc(SearchOrderUsecase searchOrderUsecase) : super(OrderManagmentStateInitial()) {
    on<OrderManagmentEvent>((event, emit) async{
      // TODO: implement event handler
         debugPrint("event..."+event.toString());
      if(event is FetchOrder){
        debugPrint("event...fetch.."+event.toString());
        emit(OrderManagmentStateLoading());
        final value = await searchOrderUsecase(data: OrdersearchParam(start: event.props[0] as String,query: event.props[1] as String));
        value.fold((l) => emit(OrderManagmentStateError(mapFailureToMessage(l))), (r) => emit(OrderManagmentStateSucsess<List<PosOrderSearch>>(r)));
      }
     else if(event is OrderPagination){
        debugPrint("event...pagination.."+event.toString());
      emit(OrderManagmentStateLoading(ispaginated: true));
      final value = await searchOrderUsecase(data: OrdersearchParam(start: event.props[0] as String,query: event.props[1] as String));
      value.fold((l) => emit(OrderManagmentStateError(mapFailureToMessage(l))), (r) => emit(OrderManagmentStateSucsess<List<PosOrderSearch>>(r,ispaginated: true,)));
      }else{
        debugPrint("event...fetch..else."+event.toString());
        emit(OrderManagmentStateLoading());
        final value = await searchOrderUsecase(data: OrdersearchParam(start: event.props[0] as String,query: event.props[1] as String));
        value.fold((l) => emit(OrderManagmentStateError(mapFailureToMessage(l))), (r) => emit(OrderManagmentStateSucsess<List<PosOrderSearch>>(r)));
      }

    });
  }
}