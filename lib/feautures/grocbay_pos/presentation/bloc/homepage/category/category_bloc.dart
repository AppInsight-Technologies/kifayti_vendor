import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../../../core/error/failuers.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/Fetch_category.dart';
import '../../../../domain/usecases/get_category.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(GetCategory getCategory) : super(CategoryStateInitial()) {
    on<CategoryEvent>((event, emit) async{
      // TODO: implement event handler
      emit(CategoryStateLoading());
      final value = await getCategory(data: NoPrams());
      value.fold((l) async=> emit(CategoryStateError(mapFailureToMessage(l))), (r) async=> emit(CategoryStateSucsess<List<CategoryFetch>>(r)));
      // TODO: implement event handler
    });
  }
}