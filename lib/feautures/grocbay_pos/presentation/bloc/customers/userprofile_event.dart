part of 'userprofile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent(String apiKey);
}
class OnUserProfile extends UserProfileEvent {
  String apiKey;

  OnUserProfile(this.apiKey) : super(apiKey);
  @override
  // TODO: implement props
  List<Object?> get props => [apiKey];
}
class ClearCustomerData extends UserProfileEvent{
  String apiKey;
  ClearCustomerData(this.apiKey) : super(apiKey);

  @override
  // TODO: implement props
  List<Object?> get props => [apiKey];

}