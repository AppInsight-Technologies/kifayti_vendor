part of 'order_managment_bloc.dart';

abstract class OrderManagmentEvent extends Equatable {
  const OrderManagmentEvent();
}

class OrderPagination extends OrderManagmentEvent {
  final String query;
  final int start;

  OrderPagination(this.query,{
    this.start = 0,
  });

  @override
  List<Object> get props => [query,start];
}

class FetchOrder extends OrderManagmentEvent {
  final int start;
  final String query;

  const FetchOrder({required this.start, required this.query});
  @override
  List<Object> get props => [start.toString(),query];
}
