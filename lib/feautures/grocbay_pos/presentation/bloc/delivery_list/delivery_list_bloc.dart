
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/delivery_list_usecase.dart';


part 'delivery_list_event.dart';
part 'delivery_list_state.dart';


class DeliveryListBloc extends Bloc<DeliveryListEvent, DeliveryListState> {
  deliveryListUsecase getdeliveryList;

  DeliveryListBloc({required this.getdeliveryList}) : super(DeliveryListInitial()) {
    on<OnDeliveryListEvent>((event, emit) async{

      emit(DeliveryListLoading());
      final DeliveryListresult =  await getdeliveryList(data:deliveryListParms(branch: event.branch));
      DeliveryListresult.fold((l) => emit(DeliveryListError(mapFailureToMessage(l))), (r) => emit(DeliveryListSucsess(r)));

      // TODO: implement event handler
    });
  }
}