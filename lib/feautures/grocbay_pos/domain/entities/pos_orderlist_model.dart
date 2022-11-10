import 'modle_entities.dart';

class PosOrderList {
  String? oId;
  String? uName;
  String? oDate;
  String? payStatus;
  int? payAmount;
  String? oStatus;

  PosOrderList(
      {this.oId,
        this.uName,
        this.oDate,
        this.payStatus,
        this.payAmount,
        this.oStatus});

  PosOrderList.fromJson(Map<String, dynamic> json) {
    oId = json['o_id'];
    uName = json['u_name'];
    oDate = json['o_date'];
    payStatus = json['pay_status'];
    payAmount = json['pay_amount'];
    oStatus = json['o_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['o_id'] = this.oId;
    data['u_name'] = this.uName;
    data['o_date'] = this.oDate;
    data['pay_status'] = this.payStatus;
    data['pay_amount'] = this.payAmount;
    data['o_status'] = this.oStatus;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
