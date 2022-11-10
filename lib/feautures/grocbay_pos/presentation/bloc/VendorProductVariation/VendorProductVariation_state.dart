part of 'VendorProductVariation.dart';

abstract class VendorProductVariationState extends Equatable {
  const VendorProductVariationState();
}
class VendorProductVariationStateInitial extends VendorProductVariationState {
  @override
  List<Object> get props => [];
}
class VendorProductVariationStateLoading extends VendorProductVariationState {

  VendorProductVariationStateLoading();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VendorProductVariationStateSucsess<T> extends VendorProductVariationState {
  T data;

  VendorProductVariationStateSucsess(this.data,);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VendorProductVariationStateError extends VendorProductVariationState {
  String e;

  VendorProductVariationStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}