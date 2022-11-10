import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:recase/recase.dart';
import '../../../../../../core/error/failuers.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../domain/entities/fetch_subcategory.dart';
import '../../../../domain/usecases/get_sub_category.dart';

part 'subCategory_event.dart';

part 'subCategory_state.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  SubcategoryBloc(GetSubCategory getSubCategory) : super(SubcategoryStateInitial()) {
    on<SubcategoryEvent>((event, emit) async{
      // TODO: implement event handler
      emit(SubcategoryStateLoading());
      final value = await getSubCategory(data: SubCatParms(allkey:S.current.ALL, catId: event.props.first as int));
      value.fold((l) => emit(SubcategoryStateError(mapFailureToMessage(l))), (r) => emit(SubcategoryStateSucsess<List<FetchSubCategory>>(r)));
      // TODO: implement event handler

    });
  }
}