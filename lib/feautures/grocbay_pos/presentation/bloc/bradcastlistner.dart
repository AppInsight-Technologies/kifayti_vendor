
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/entities/check_loyalty_model.dart';
import '../../domain/entities/get_loyalty_model.dart';
import 'Loyalty/loyalty_bloc.dart';
import 'loginBloc/login_bloc.dart';
import '../../domain/entities/getRestaraunt.dart';

class UserDatabase {
 BuildContext context;
  UserDatabase(this.context);
 call({required Function(getUser) sucsess, required Function(String) failes}){
   BlocProvider.of<LoginBloc>(context).add(FetchUserData());
   BlocProvider.of<LoginBloc>(context).stream.asBroadcastStream().listen((event) async{
      if(event is LoginSucsess<getUser>){
        sucsess(event.data);
      }else if(event is LoginError){
        failes(event.e);
      }
    });
  }
}

class GetLoyaltyDatabase {
  BuildContext context;
  String branch;
  GetLoyaltyDatabase(this.context,this.branch);
  call({required Function(getLoyalty) sucsess, required Function(String) failes}){
    // BlocProvider.of<LoyaltyBloc>(context).add(OnGetLoyalty(branch));
    BlocProvider.of<LoyaltyBloc>(context).stream.asBroadcastStream().listen((event) async{
      if(event is LoyaltySucsess<getLoyalty>){
        sucsess(event.data);
      }else if(event is LoyaltyError){
        failes(event.e);
      }
    });
  }
}

class CheckLoyaltyDatabase {
  BuildContext context;
  String total;
  String branch;
  CheckLoyaltyDatabase(this.context,this.total,this.branch);
  call({required Function(checkLoyalty) sucsess, required Function(String) failes}){
    // BlocProvider.of<LoyaltyBloc>(context).add(OnCheckLoyalty(total,branch, branch: '', user_point: '', total: ''));
    BlocProvider.of<LoyaltyBloc>(context).stream.asBroadcastStream().listen((event) async{
      if(event is LoyaltySucsess<checkLoyalty>){
        sucsess(event.data);
      }else if(event is LoyaltyError){
        failes(event.e);
      }
    });
  }
}