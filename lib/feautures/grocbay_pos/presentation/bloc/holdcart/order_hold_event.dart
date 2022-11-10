part of 'order_hold.dart';

abstract class OrderHoldEvent extends Equatable {
  const OrderHoldEvent();
}

class OrderHoldInitial extends OrderHoldEvent {
  const OrderHoldInitial();

  @override
  List<Object> get props => [];
}
