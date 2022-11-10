part of 'shopstatus.dart';

abstract class ShopstatusState extends Equatable {
  const ShopstatusState();
}


class ShopstatusStateInitial extends ShopstatusState {
  @override
  List<Object> get props => [];
}

class ShopstatusStateLoading extends ShopstatusState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShopstatusStateSucsess<T> extends ShopstatusState {
  T data;

  ShopstatusStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShopstatusStateError extends ShopstatusState {
  String e;

  ShopstatusStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

