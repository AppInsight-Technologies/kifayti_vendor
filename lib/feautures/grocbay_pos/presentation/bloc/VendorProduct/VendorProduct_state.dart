part of 'VendorProduct.dart';

abstract class VendorProductState extends Equatable {
  const VendorProductState();
}

class VendorProductInitial extends VendorProductState {
  @override
  List<Object> get props => [];
}

class VendorProductLoading extends  VendorProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class VendorProductSucsess<T> extends  VendorProductState{
  T data;
  VendorProductSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class VendorProductError extends  VendorProductState{
  String e;
  VendorProductError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}