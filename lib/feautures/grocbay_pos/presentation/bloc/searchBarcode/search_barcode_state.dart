part of 'search_barcode_bloc.dart';

abstract class SearchBarcodeState extends Equatable {
  const SearchBarcodeState();
}


class SearchBarcodeInitial extends SearchBarcodeState {
  @override
  List<Object> get props => [];
}

class SearchBarcodeLoading extends  SearchBarcodeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SearchBarcodeSucsess<T> extends  SearchBarcodeState{
  T data;
  SearchBarcodeSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class SearchBarcodeError extends  SearchBarcodeState{
  String e;
  SearchBarcodeError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}