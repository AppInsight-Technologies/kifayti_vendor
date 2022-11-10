import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
enum DBTable{
  UserProfile,CartData,DataFetchHistory,PaymentData,customerdata
}

class HiveDB<T> extends HiveState<T>{
  HiveDB({required DBTable database}) : super(_getBox(database));
  static init()async {

    if(!kIsWeb) {
      final document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
    }
  }
// static HiveState db({
//  required DBTable database
// }){
//   return HiveState<T>(_getBox(database));
// }
}

String _getBox(DBTable database) {
  switch(database){
    case DBTable.UserProfile: return "db_profile";
    case DBTable.CartData: return "db_cart";
    case DBTable.DataFetchHistory: return "db_travel_history";
    case DBTable.PaymentData: return "db_payment_data";
    case DBTable.customerdata:return "db_customer";
  }
}

abstract class HiveState <T>{
  late Box box;
  String database;
  HiveState(this.database);
  Future<T> add({dynamic key,required T value}) async {
    box = await Hive.openBox<T>(database);
    if(key!=null) {
      box.put(key, value);
    } else {
      box.add(value);
    }
    return value;
    // await box.close();
  }
  remove({dynamic key}) async {
    // if(box.isOpen) box.close();
    box = await Hive.openBox<T>(database);
    if(key is int){
      box.deleteAt(key);
    }else{
      box.delete(key);
    }
    await box.close();
  }
  get({dynamic key}) async {
    var val;
    // if(!box.isOpen)
    box = await Hive.openBox<T>(database);
    if(key is int){
      return await box.getAt(key);
    }else{
      return  await box.get(key);
    }
    // Future.delayed(Duration(microseconds: 200,()=>));
    // await box.close();
    return val;
  }
  Future<T> update({required dynamic key,required T value}) async{
    box = await Hive.openBox<T>(database);
    if(key is int){
        await box.putAt(key,value);
    }else{
       await box.put(key,value);
    }
    return value;
    // await box.close();
  }
  cleare() async {
    box = await Hive.openBox(database);
    await box.clear();
    await box.close();
  }
  lisen() {
    return  Hive.box(database).listenable();
  }
}