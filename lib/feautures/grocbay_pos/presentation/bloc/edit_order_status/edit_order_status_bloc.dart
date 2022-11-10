
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/edit_order_status_usecase.dart';

part 'edit_order_status_event.dart';
part 'edit_order_status_state.dart';


class EditOrderStatusBloc extends Bloc<EditOrderStatusEvent, EditOrderStatusState> {
  editOrderStatusUsecase editOrderStatus;

  EditOrderStatusBloc({required this.editOrderStatus}) : super(EditOrderStatusStateInitial()) {
    on<OnEditOrderStatusEvent>((event, emit) async{

      emit(EditOrderStatusStateLoading());
      final EditOrderStatusStateresult =  await editOrderStatus(data:event.editOederparm);
      EditOrderStatusStateresult.fold((l) async=> emit(EditOrderStatusStateError(mapFailureToMessage(l))), (r) async=> emit(EditOrderStatusStateSucsess(r)));
      // TODO: implement event handler
    });
  }
}