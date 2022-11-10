
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/get_all_count_usecase.dart';


part 'get_All_Count_event.dart';
part 'get_All_Count_state.dart';


class GetAllCountBloc extends Bloc<GetAllCountEvent, GetAllCountState> {
  GetAllCountUsecase getGetAllCount;

  GetAllCountBloc({required this.getGetAllCount}) : super(GetAllCountInitial()) {
    on<OnGetAllCountEvent>((event, emit) async{

      emit(GetAllCountLoading());
      final GetAllCountresult =  await getGetAllCount(data:PosGetAllParms(branch: event.branch));
      GetAllCountresult.fold((l) => emit(GetAllCountError(mapFailureToMessage(l))), (r) => emit(GetAllCountSucsess(r)));

      // TODO: implement event handler
    });
  }
}