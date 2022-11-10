part of 'search_barcode_bloc.dart';

abstract class SearchBarcodeEvent extends Equatable {
  const SearchBarcodeEvent();
}
class OnSearchBarcode extends SearchBarcodeEvent {
  String query;

  OnSearchBarcode(this.query);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
