
import 'package:bloc/bloc.dart';

import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/barcode_search_usecase.dart';
import 'package:equatable/equatable.dart';

part 'search_barcode_event.dart';
part 'search_barcode_state.dart';


class SearchBarcodeBloc extends Bloc<SearchBarcodeEvent, SearchBarcodeState> {
  SearchBarcodeUsecase getSearchBarcodeData;

  SearchBarcodeBloc({required this.getSearchBarcodeData}) : super(SearchBarcodeInitial()) {
    on<OnSearchBarcode>((event, emit) async{

      emit(SearchBarcodeLoading());
      final SearchBarcoderesult =  await getSearchBarcodeData(data:BarcodesearchData(event.query));
      SearchBarcoderesult.fold((l) => emit(SearchBarcodeError(mapFailureToMessage(l))), (r) => emit(SearchBarcodeSucsess(r)));

      // TODO: implement event handler
    });
  }
}