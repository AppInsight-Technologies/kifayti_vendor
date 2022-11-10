part of 'subCategory_bloc.dart';

abstract class SubcategoryState extends Equatable {
  const SubcategoryState();
}


class SubcategoryStateInitial extends SubcategoryState {
  @override
  List<Object> get props => [];
}

class SubcategoryStateLoading extends SubcategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubcategoryStateSucsess<T> extends SubcategoryState {
  T data;

  SubcategoryStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubcategoryStateError extends SubcategoryState {
  String e;

  SubcategoryStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

