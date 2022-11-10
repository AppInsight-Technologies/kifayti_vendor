class EmailCheck {
  bool? status;
  String? type;

  EmailCheck({this.status, this.type});

  EmailCheck.fromJson(Map<String, dynamic> json) {
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
