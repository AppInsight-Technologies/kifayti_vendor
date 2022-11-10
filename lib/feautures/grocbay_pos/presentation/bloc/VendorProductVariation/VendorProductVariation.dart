import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import '../..//core/util/presentation/controller/product_add_controller.dart';

import '../../../domain/usecases/VendorProduct_usecase.dart';

part 'VendorProductVariation_event.dart';

part 'VendorProductVariation_state.dart';

class VendorProductVariationBloc extends Bloc<VendorProductVariationEvent, VendorProductVariationState> {
  VendorProductVariationBloc() : super(VendorProductVariationStateInitial()){

    on<VendorProductVariationEvent>((event, emit) async{
      emit(VendorProductVariationStateLoading());
      if (event is VariationEventInitial){
        emit(VendorProductVariationStateSucsess(event.props.first));
      }

      // TODO: implement event handler
    });
  }


}