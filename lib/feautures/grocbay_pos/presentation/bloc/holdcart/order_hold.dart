import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositorie/repository_provider.dart';
import '../../../domain/usecases/cart_item_usecase.dart';

part 'order_hold_event.dart';
part 'order_hold_state.dart';

class OrderHoldBloc extends Bloc<OrderHoldEvent, OrderHoldState> {
  OrderHoldBloc( CartItemUseCase usecase ) : super(OrderHoldStateInitial()) {
    on<OrderHoldEvent>((event, emit) async{
      // TODO: implement event handler
      final holdvalue = await usecase.holdCart(data: CartParms(DB.GET));
    });
  }
}