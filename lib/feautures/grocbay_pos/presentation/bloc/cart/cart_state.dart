part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}


class CartStateInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartStateLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartStateSucsess<T> extends CartState {
  T data;

  CartStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartStateError extends CartState {
  String e;

  CartStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

