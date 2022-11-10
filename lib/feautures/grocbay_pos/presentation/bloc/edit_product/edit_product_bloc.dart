
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/error/failuers.dart';
import '../../../domain/usecases/edit_product_usecase.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';


class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  editProductUsecase editProduct;

  EditProductBloc({required this.editProduct}) : super(EditProductStateInitial()) {
    on<OnEditProductEvent>((event, emit) async{

      emit(EditProductStateLoading());
      final EditProductresult =  await editProduct(data:event.editOederparm);
      EditProductresult.fold((l) async=> emit(EditProductStateError(mapFailureToMessage(l))), (r) async=> emit(EditProductStateSucsess(r)));
      // TODO: implement event handler
    });
  }
}