
part of 'picker_list_bloc.dart';
abstract class PickerListEvent extends Equatable {
  const PickerListEvent(String branch);
}
class OnPickerListEvent extends PickerListEvent {
  String branch;

  OnPickerListEvent(this.branch) : super(branch);
  @override
  // TODO: implement props
  List<Object?> get props => [branch];
}
