class PickerListModel {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? registrationKey;
  String? password;
  String? userType;
  String? isActive;
  String? roles;
  String? branch;
  String? branchtype;

  PickerListModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.registrationKey,
        this.password,
        this.userType,
        this.isActive,
        this.roles,
        this.branch,
        this.branchtype});

  PickerListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    registrationKey = json['registrationKey'];
    password = json['password'];
    userType = json['userType'];
    isActive = json['isActive'];
    roles = json['roles'];
    branch = json['branch'];
    branchtype = json['branchtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['registrationKey'] = this.registrationKey;
    data['password'] = this.password;
    data['userType'] = this.userType;
    data['isActive'] = this.isActive;
    data['roles'] = this.roles;
    data['branch'] = this.branch;
    data['branchtype'] = this.branchtype;
    return data;
  }
}