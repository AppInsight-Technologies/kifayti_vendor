part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}


class ProductStateInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductStateLoading extends ProductState {
  bool ispaginated;
  ProductStateLoading({this.ispaginated = false});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductStateSucsess<T> extends ProductState {
  T data;
  final bool ispaginated;
  FetchSubCategory subcat;
  bool all;

  ProductStateSucsess(this.data, {this.ispaginated = false, required this. subcat,this.all = true});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductStateError extends ProductState {
  String e;

  ProductStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

