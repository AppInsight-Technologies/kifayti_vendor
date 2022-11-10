part of 'VendorProduct.dart';

abstract class VendorProductEvent extends Equatable {
  const VendorProductEvent();
}

class OnProductAdd extends VendorProductEvent {
  //ProductAddParms model;
  AddProductController model;
  OnProductAdd(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [model];
}
