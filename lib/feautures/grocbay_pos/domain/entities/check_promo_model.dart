class CheckPromo {
  String? status;
  String? prmocodeType;
  String? msg;
  String? amount;

  CheckPromo({this.status, this.prmocodeType, this.msg, this.amount});

  CheckPromo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    prmocodeType = json['prmocodeType'];
    msg = json['msg'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['prmocodeType'] = this.prmocodeType;
    data['msg'] = this.msg;
    data['amount'] = this.amount;
    return data;
  }
}
