import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'modle_entities.g.dart';
@HiveType(typeId: 1)
class ModelEntities extends Equatable {
  @HiveField(0)
  String data = '''{"data":[]}''';
  ModelEntities(this.data);
  ModelEntities.fromJson(this.data);
  // Map<String,dynamic>? tojson(){
  //   Map<String,dynamic> _data = Map<String,dynamic>();
  //   return _data["data"] = jsonDecode(data!);
  // }
  @override
  // TODO: implement props
  List<Object?> get props => [];

}