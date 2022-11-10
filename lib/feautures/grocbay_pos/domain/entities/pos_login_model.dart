import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import 'modle_entities.dart';

class PosLogin {
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? branch;
  String? apiKey;
  String? registrationKey;
  String? password;
  String? userType;
  bool? isActive;
  List<String>? roles;
  String? branchtype;

  PosLogin(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.branch,
        this.apiKey,
        this.registrationKey,
        this.password,
        this.userType,
        this.isActive,
        this.roles,
        this.branchtype});

  PosLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    branch = json['branch'];
    apiKey = json['api_key'];
    registrationKey = json['registration_key'];
    password = json['password'];

    userType = json['user_type'];
    isActive = json['is_active'];
    roles = json['roles'].cast<String>();
    branchtype = json['branchtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['branch'] = this.branch;
    data['api_key'] = this.apiKey;
    data['registration_key'] = this.registrationKey;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['roles'] = this.roles;
    data['branchtype'] = this.branchtype;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
