class CustomerRegister {
  bool? status;
  Data? data;
  int? userId;
  String? membership;

  CustomerRegister({this.status, this.data, this.userId, this.membership});

  CustomerRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    userId = json['userId'];
    membership = json['membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['userId'] = this.userId;
    data['membership'] = this.membership;
    return data;
  }
}

class Data {
  int? apiKey;

  Data({this.apiKey});

  Data.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = this.apiKey;
    return data;
  }
}
