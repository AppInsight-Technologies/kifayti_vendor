part of 'order_details.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();
}

class OrderDetailsInitial extends OrderDetailsEvent {
  const OrderDetailsInitial();

  @override
  List<Object> get props => [];
}