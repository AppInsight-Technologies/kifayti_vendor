class MobileCheck {
  bool? status;
  String? type;

  MobileCheck({this.status, this.type});

  MobileCheck.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    return data;
  }
}
