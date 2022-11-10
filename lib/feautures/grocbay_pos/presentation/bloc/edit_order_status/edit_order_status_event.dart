
part of 'edit_order_status_bloc.dart';
abstract class EditOrderStatusEvent extends Equatable {

}
class OnEditOrderStatusEvent extends EditOrderStatusEvent {
  editOrderStatusParams editOederparm;

  OnEditOrderStatusEvent(this.editOederparm);
  @override
  // TODO: implement props
  List<Object?> get props => [editOederparm];
}
