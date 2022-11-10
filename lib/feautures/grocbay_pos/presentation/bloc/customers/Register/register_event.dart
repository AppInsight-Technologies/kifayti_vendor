part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}
class OnRegister extends RegisterEvent {
  String username;
  String email;
  String mobileNo;
  String tokenId;
  String device;
  String path;
  String branch;
  String referralid;
 int sex;

  OnRegister(this.username, this.mobileNo, this.email, this.tokenId, this.device, this.path, this.branch, this.referralid, this.sex);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}




