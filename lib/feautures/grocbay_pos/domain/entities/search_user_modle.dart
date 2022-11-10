import 'modle_entities.dart';

class SearchUser {
  String? uId;
  String? uName;
  String? uNumber;

  SearchUser({this.uId, this.uName, this.uNumber});

  SearchUser.fromJson(Map<String, dynamic> json) {
    uId = json['u_id'];
    uName = json['u_name'];
    uNumber = json['u_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_id'] = this.uId;
    data['u_name'] = this.uName;
    data['u_number'] = this.uNumber;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
