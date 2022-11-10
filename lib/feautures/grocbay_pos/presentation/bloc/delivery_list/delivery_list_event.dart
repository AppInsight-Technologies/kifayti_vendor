
part of 'delivery_list_bloc.dart';
abstract class DeliveryListEvent extends Equatable {
  const DeliveryListEvent(String branch);
}
class OnDeliveryListEvent extends DeliveryListEvent {
  String branch;

  OnDeliveryListEvent(this.branch) : super(branch);
  @override
  // TODO: implement props
  List<Object?> get props => [branch];
}
