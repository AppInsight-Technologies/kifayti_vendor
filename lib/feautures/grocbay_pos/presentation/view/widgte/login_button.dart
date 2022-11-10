import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/getRestaraunt.dart';
import '../../bloc/loginBloc/login_bloc.dart';
import '../../bloc/themeControllBloc/theme_bloc.dart';
import '../../rought_genrator.dart';
import 'dailog/alert _dailog.dart';

class LoginButton extends StatelessWidget with Navigations{
  final String email;
  final String password;

  // final FocusNode b_focus;

  const LoginButton(/*this.b_focus,*/{Key? key,required this.email,required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 18.0,),
      child: Container(
         height:(kIsWeb)? 40:50,
        padding:EdgeInsets.all(4.0),
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColor,//Colors.green,
     ),
        child:  FlatButton(
            // focusNode: b_focus,
            onPressed: () {
              if(email == '' || email == null || password == '' || password == null){
                print("here");
                Alert().showallert(context,messege:S.of(context).please_enter_the_fields);
              }
              else{
                BlocProvider.of<LoginBloc>(context).add(OnCLickLogin(email, password));
              }
 },
            child:  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is LoginSucsess<getUser>) {
                        final statse = state.data;
                        if ((!(sl<SharedPreferences>().getBool(Prefrence
                            .LOGEDIN) ?? false))) {
                          sl<SharedPreferences>().setBool(
                              Prefrence.LOGEDIN, true);
                          sl<SharedPreferences>().setString(
                              Prefrence.BRANCH, statse.branch!);
                          Navigation(context, navigatore: NavigatoreTyp
                              .homenav);
                          sl<SharedPreferences>().setString("userType", statse
                              .userType!);
                          sl<SharedPreferences>().setString("title","DASHBOARD");
                          if (statse.userType != "Admin") {
                            sl<SharedPreferences>().setString(
                                Prefrence.posId, statse.posId.toString());
                            sl<SharedPreferences>().setString(
                                Prefrence.posPoint, statse.posPoint!);
                          }
                          BlocProvider.of<ThemeBloc>(context).add( SetTheme(sl<SharedPreferences>().getString("userType") == "Admin"?ThemeName.vendor:ThemeName.pos));
                        }
                      }
                      if (state is LoginError) {
                        Alert().showallert(
                            context, messege: S.of(context).invalid_credentials);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator(color: Colors.white,);
                      } else {
                        return  Text(
                          S.of(context).Login,
                          style: TextStyle(
                              color: Colors.white, fontSize: 25),
                        );
                      }
                    },
                  )

        ),
      ),
    );
  }
}
