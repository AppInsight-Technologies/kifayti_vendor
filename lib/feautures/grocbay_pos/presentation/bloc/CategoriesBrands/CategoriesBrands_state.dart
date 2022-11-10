part of 'CategoriesBrands_bloc.dart';

abstract class CategoriesBrandsState extends Equatable {
  const CategoriesBrandsState();
}


class CategoriesBrandsInitial extends CategoriesBrandsState {
  @override
  List<Object> get props => [];
}
class CategoriesBrandsLoading extends  CategoriesBrandsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CategoriesBrandsSucsess<T> extends  CategoriesBrandsState{
  T data;
  CategoriesBrandsSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class CategoriesBrandsError extends  CategoriesBrandsState{
  String e;
  CategoriesBrandsError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}