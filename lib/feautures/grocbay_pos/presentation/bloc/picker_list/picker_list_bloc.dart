
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/picker_list_usecase.dart';


part 'picker_list_event.dart';
part 'picker_list_state.dart';


class PickerListBloc extends Bloc<PickerListEvent, PickerListState> {
  pickerListUsecase getPickerList;

  PickerListBloc({required this.getPickerList}) : super(PickerListInitial()) {
    on<OnPickerListEvent>((event, emit) async{

      emit(PickerListLoading());
      final PickerListresult =  await getPickerList(data:pickerListParms(branch: event.branch));
      PickerListresult.fold((l) => emit(PickerListError(mapFailureToMessage(l))), (r) => emit(PickerListSucsess(r)));

      // TODO: implement event handler
    });
  }
}