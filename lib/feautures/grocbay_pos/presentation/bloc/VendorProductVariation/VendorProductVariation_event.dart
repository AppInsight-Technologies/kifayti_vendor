part of 'VendorProductVariation.dart';

abstract class VendorProductVariationEvent extends Equatable {}

class VariationEventInitial extends VendorProductVariationEvent {
  Variation variationlistobj;

  VariationEventInitial(this.variationlistobj);

  @override
  List<Object> get props => [variationlistobj];
}
