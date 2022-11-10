part of 'userprofile_bloc.dart';



abstract class UserProfileState extends Equatable {
  const UserProfileState();
}


class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}
class UserProfileLoading extends  UserProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UserProfileSucsess<T> extends  UserProfileState{
  T data;
  UserProfileSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class UserProfileError extends  UserProfileState{
  String e;
  UserProfileError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}