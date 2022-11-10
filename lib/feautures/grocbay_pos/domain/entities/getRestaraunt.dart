import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
part 'getRestaraunt.g.dart';
@HiveType(typeId: 0)
class getUser {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? mobileNumber;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? branch;
  @HiveField(6)
  String? apiKey;
  @HiveField(7)
  String? registrationKey;
  @HiveField(8)
  String? userType;
  @HiveField(9)
  bool? isActive;
  @HiveField(10)
  List<String>? roles;
  @HiveField(11)
  String? branchtype;
  @HiveField(12)
  int? posId;
  @HiveField(13)
  String? posPoint;

  getUser(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.branch,
        this.apiKey,
        this.registrationKey,
        this.userType,
        this.isActive,
        this.roles,
        this.branchtype,
        this.posId,
        this.posPoint,
      });

  getUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    branch = json['branch'];
    apiKey = json['api_key'];
    registrationKey = json['registration_key'];
    userType = json['user_type'];
    sl<SharedPreferences>().setString("userType", json['user_type']);
    isActive = json['is_active'];
    roles = json['roles'].cast<String>();
    branchtype = json['branchtype'];
    posId = json['id'];
    posPoint = json['pos_point'];
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
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['roles'] = this.roles;
    data['branchtype'] = this.branchtype;
    data['posId'] = this.posId;
    data['posPoint'] = this.posPoint;
    return data;
  }
}