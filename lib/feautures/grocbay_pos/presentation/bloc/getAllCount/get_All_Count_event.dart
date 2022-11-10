
part of 'get_All_Count_bloc.dart';
abstract class GetAllCountEvent extends Equatable {
  const GetAllCountEvent(String branch);
}
class OnGetAllCountEvent extends GetAllCountEvent {
  String branch;

  OnGetAllCountEvent(this.branch) : super(branch);
  @override
  // TODO: implement props
  List<Object?> get props => [branch];
}
