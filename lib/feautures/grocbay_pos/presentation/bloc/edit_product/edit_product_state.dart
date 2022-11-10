
part of 'edit_product_bloc.dart';

abstract class EditProductState extends Equatable {
  const EditProductState();
}


class EditProductStateInitial extends EditProductState {
  @override
  List<Object> get props => [];
}
class EditProductStateLoading extends  EditProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class EditProductStateSucsess<T> extends  EditProductState{

  T data;
  EditProductStateSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class EditProductStateError extends  EditProductState{
  String e;
  EditProductStateError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}