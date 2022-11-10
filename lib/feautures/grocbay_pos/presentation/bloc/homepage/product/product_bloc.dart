import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failuers.dart';
import '../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/fetch_category_product.dart';
import '../../../../domain/entities/fetch_subcategory.dart';
import '../../../../domain/usecases/get_category_product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(GetCategoryProduct getCategoryProduct) : super(ProductStateInitial()) {
    on<ProductEvent>((event, emit) async{
      if(event is OnProductGet) {
        emit(ProductStateLoading());
        emit(ProductStateSucsess<List<FetchCategoryProduct>>(event.data,subcat:  event.props.first as FetchSubCategory,));
      }else if(event is ProductPagination){
        emit(ProductStateLoading(ispaginated: true));
        final value = await getCategoryProduct(data: CatProductParms(id: (event.props.first as FetchSubCategory).id!,start:event.props[1].toString(), end:event.props[2].toString(), branch:"${sl<SharedPreferences>().getString(Prefrence.BRANCH)}", language_id:sl<SharedPreferences>().getString("Languageid")!, type: event.props.last as int));
        value.fold((l) => emit(ProductStateError(mapFailureToMessage(l))), (r) => emit(ProductStateSucsess<List<FetchCategoryProduct>>(r,ispaginated: true,subcat: event.props.first as FetchSubCategory,all:event.props.last as int==1 )));
      }else{
        emit(ProductStateLoading());
        final value = await getCategoryProduct(data: CatProductParms(id: (event.props.first as FetchSubCategory).id!,start:"0", end:"0", branch:sl<SharedPreferences>().getString(Prefrence.BRANCH)!, language_id:sl<SharedPreferences>().getString("Languageid")!, type: event.props.last as int));
        value.fold((l) => emit(ProductStateError(mapFailureToMessage(l))), (r) => emit(ProductStateSucsess<List<FetchCategoryProduct>>(r,subcat:  event.props.first as FetchSubCategory,all:event.props.last as int==1 )));
      }
      // TODO: implement event handler
    });
  }
}