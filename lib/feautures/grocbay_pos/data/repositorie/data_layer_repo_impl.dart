import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
// import '../..//core/usecases/usecase.dart';
import '../../../../core/data/hive_db.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failuers.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/modle_entities.dart';
import '../../domain/repositorie/repository_provider.dart';
import '../datasours/remote_data_sources.dart';
import '../datasours/local_data_source.dart';
import '../models/repository_modle.dart';

typedef Future<RepositoryModel> GetRequest();
class DataLayerRepositoryImpl implements DependencyRepostProvider<Map<String, dynamic>>{
  RemoteDataSourceImpl remoteDataSource;
  NetworkInfoImpl networkInfo;
  LocalDataSourceImpl localDataSource;
  DataLayerRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this. networkInfo});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRequest(Params param) =>_getRequest(param.uri.path,() => remoteDataSource.getRequest(param));
  Future<Either<Failure, Map<String, dynamic>>> _getRequest(String key,GetRequest getRequest) async{
   print("netwirk info");
    if (await networkInfo.isConnected) {
      try {
        if (kDebugMode) {
          print("reqesting data...");
        }
        final remoteTrivia = await getRequest();
       await localDataSource.cachedData(key:key,value: remoteTrivia,table: DBTable.DataFetchHistory);
        // final localTrivia = await localDataSource.getCachedData(key: key, table: DBTable.DataFetchHistory);

        return Right(jsonDecode(remoteTrivia.data));
      } on ServerExceptions {
        print("server exception");
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getCachedData(key: key,table: DBTable.DataFetchHistory);
        return Right(jsonDecode(localTrivia.data));
      } on CacheExceptions {
        return Left(CacheFailure());
        // TODO
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getLocalDBRequest(LDBParams param) async{
    try{
      if(param.methed==DB.GET) {
        final localTrivia = await localDataSource.getCachedData(
            key: param.key, table: param.table);
        if(localTrivia.data.trim().trimRight().toString()=="{}"){
          print("cache execution");
          return Left(CacheFailure());
        }else{
          return Right(jsonDecode(localTrivia.data));
        }
      }
      else if(param.methed==DB.SET){
       await localDataSource.cachedData(key:param.key,value: RepositoryModel.fromJson(param.data!),table: param.table);
        final localTrivia = await localDataSource.getCachedData(key: param.key,table: param.table);
        return Right(jsonDecode(localTrivia.data));
      } else if(param.methed==DB.UPDATE){
        final localTrivia = await localDataSource.updateCachedData(key: param.key,table: param.table, value:RepositoryModel.fromJson(param.data!));
        return Right(jsonDecode(localTrivia.data));
      }else if(param.methed==DB.REMOVE){
        localDataSource.removeCachedData(key:param.key,table: param.table);
        final localTrivia = await localDataSource.getCachedData(key: param.key,table: param.table);
        return Right(jsonDecode(localTrivia.data));
      }else if(param.methed == DB.CLEAR){
        localDataSource.clearCacheData(table: param.table);
        return Right(jsonDecode("[]"));
      }else {
        final localTrivia = await localDataSource.getCachedData(key: param.key,table: DBTable.DataFetchHistory);
        return Right(jsonDecode(localTrivia.data));
      }
    }on CacheExceptions{
      return Left(CacheFailure());
    }
  }

}