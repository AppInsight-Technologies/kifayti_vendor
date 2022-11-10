
part of 'edit_product_bloc.dart';
abstract class EditProductEvent extends Equatable {

}
class OnEditProductEvent extends EditProductEvent {
 editProductEventParams editOederparm;

  OnEditProductEvent(this.editOederparm);
  @override
  // TODO: implement props
  List<Object?> get props => [editOederparm];
}
