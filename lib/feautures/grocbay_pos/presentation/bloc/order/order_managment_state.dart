part of 'order_managment_bloc.dart';

abstract class OrderManagmentState extends Equatable {
  const OrderManagmentState();
}


class OrderManagmentStateInitial extends OrderManagmentState {
  @override
  List<Object> get props => [];
}

class OrderManagmentStateLoading extends OrderManagmentState {
  bool ispaginated;
  OrderManagmentStateLoading({this.ispaginated = false});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderManagmentStateSucsess<T> extends OrderManagmentState {
  T data;
  final bool ispaginated;
  OrderManagmentStateSucsess(this.data,{this.ispaginated = false});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderManagmentStateError extends OrderManagmentState {
  String e;

  OrderManagmentStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

