part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}


class CategoryStateInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryStateLoading extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryStateSucsess<T> extends CategoryState {
  T data;

  CategoryStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryStateError extends CategoryState {
  String e;

  CategoryStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

