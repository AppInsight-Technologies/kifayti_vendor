import 'package:dartz/dartz.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failuers.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../injection_container.dart';
import '../entities/pos_ordersearch_model.dart';
import '../repositorie/repository_provider.dart';

class SearchOrderUsecase extends UseCase<List<PosOrderSearch>,OrdersearchParam> {
  DependencyRepostProvider repo;

  SearchOrderUsecase({required this.repo});
  @override
  Future<Either<Failure, List<PosOrderSearch>>> call({OrdersearchParam? data}) async{
    // TODO: implement call
    final value = await repo.getRequest(Params(uri: Uri.parse("pos-order-search"),methed: Methed.Post,data: {"query":data!.query, "branch":sl<SharedPreferences>().getString(Prefrence.BRANCH),"start":data.start}));
    return  Future.value(value.fold((l) =>Left(l), (r) =>Right( OrderResp.fromJson(r).data!)));
  }
}
class OrdersearchParam {
  final String query;
  final String start;
  OrdersearchParam({required this.start, required this.query}) ;
}
class OrderResp {
  bool? status;
  List<PosOrderSearch>? data;

  OrderResp({this.status, this.data});

  OrderResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PosOrderSearch>[];
      json['data'].forEach((v) {
        data!.add(new PosOrderSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

