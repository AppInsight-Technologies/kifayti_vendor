import 'dart:convert';

// import '../..//core/data/hive_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/hive_db.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/modle_entities.dart';
import '../models/repository_modle.dart';


abstract class LocalDataSource{
  Future<ModelEntities> getCachedData({required DBTable table ,required String key});
  Future<void> removeCachedData({required DBTable table ,required String key});
  Future<void> cachedData({required DBTable table ,required String key,required RepositoryModel value});
  Future<void> updateCachedData({required DBTable table ,required String key,required RepositoryModel value});
  Future<void> clearCacheData({required DBTable table ,});
}
class LocalDataSourceImpl implements LocalDataSource{
   final SharedPreferences sharedPreferences;
   LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<ModelEntities> cachedData({required DBTable table ,required String key,required RepositoryModel value}) {
    // TODO: implement cacheNumberTrivia
    return HiveDB<ModelEntities>(database: table).add(key: key,value: ModelEntities.fromJson(value.data));
  }

  @override
  Future<ModelEntities> getCachedData({required DBTable table ,required String key}) async{
    // TODO: implement getLastNumberTrivia
    //  sharedPreferences.getString(key);
     try {
       final jsonString = await HiveDB<ModelEntities>(database: table).get(key: key);
           if (jsonString != null) {
        return Future.value(jsonString);
           } else{
             return Future.value(ModelEntities.fromJson('''{"data":[]}'''));
           }
     }  catch (e) {
       throw CacheExceptions();
       // TODO
     }
  }

  @override
  Future<void> removeCachedData({required DBTable table, required String key}) async{
    // TODO: implement removeCachedData
    final jsonString = await HiveDB<ModelEntities>(database: table).remove(key: key);
    if (jsonString != null) {
      return Future.value(jsonString);
    } else{
      return Future.value(ModelEntities.fromJson('''{"data":[]}'''));
    }
  }

  @override
  Future<ModelEntities> updateCachedData({required DBTable table, required String key, required RepositoryModel value}) async{
    // TODO: implement updateCachedData
    return await HiveDB<ModelEntities>(database: table).update(key: key, value: value);
  }

  @override
  Future<void> clearCacheData({required DBTable table}) async{
    // TODO: implement clearCacheData
    await HiveDB<ModelEntities>(database: table).cleare();

  }

}