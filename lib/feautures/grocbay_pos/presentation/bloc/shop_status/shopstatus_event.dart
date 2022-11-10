part of 'shopstatus.dart';

abstract class ShopstatusEvent extends Equatable {
  const ShopstatusEvent();
}

class ShopstatusInitial extends ShopstatusEvent {
  const ShopstatusInitial();

  @override
  List<Object> get props => [];
}
class ShopstatusUpdate extends ShopstatusEvent {
  const ShopstatusUpdate();

  @override
  List<Object> get props => [];
}