
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../bloc/loginBloc/login_bloc.dart';
import '../../rought_genrator.dart';
import '../widgte/login_button.dart';

class Login extends StatefulWidget with Navigations {

  Login({Key? key}) :super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController passwordcontroller;
  late TextEditingController emailcontroller;
  String email="";
  String password="";
  final _form = GlobalKey<FormState>();
  bool obsecuretext = true;

  late Function(void Function() p1) buttonstate;
@override
  void initState() {
  emailcontroller = TextEditingController(text: "");
  passwordcontroller = TextEditingController(text: "");
  //sl<SharedPreferences>().setString("userType","");
    // TODO: implement initState
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailcontroller.addListener(() {
      buttonstate(() {
       email = emailcontroller.value.text;
     });
    });
    passwordcontroller.addListener(() {
      buttonstate(() {
       password = passwordcontroller.value.text;
     });
    });

   return (LayoutView(context).isMobile)?
     Scaffold(
      //key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body:
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
              child: Image.asset( "assets/icons/logo1.png",
                width: MediaQuery.of(context).size.width*0.40,
                height: 300,
                //fit: BoxFit.fill,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(40),
              //   child: SvgPicture.asset("assets/img/Logo.svg", width: 20, height: 20,color: Colors.white,),
              // ),
            ),
          ),
          /*Positioned(
              top: config.App(context).appHeight(37) - 120,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(37),
                child: Text(
                  S.of(context).lets_start_with_login,
                  style: Theme.of(context).textTheme.display3.merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),*/
          Stack(
            children:[
              Positioned(
                top: MediaQuery.of(context).size.height/2.5,//config.App(context).appHeight(37) - 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,

                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                  width: MediaQuery.of(context).size.width -40,//config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                  child:
                  Form(
                    //key: _con.loginFormKey,
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(S.of(context).welcome,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(height: 15,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          cursorColor: Colors.black,
                          //onSaved: (input) => _con.user.email = input,
                          onSaved: (value) {
                            //addMobilenumToSF(value);
                          },
                          //inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return S.of(context).please_enter_mobile_number;
                          //   }
                          //   return null; //it means user entered a valid input
                          // },
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            fillColor: Colors.black,
                            hoverColor: Colors.black,
                            contentPadding: EdgeInsets.all(5),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  emailcontroller.clear();
                                });
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(Icons.cancel,size: 20,color: Colors.grey[400],),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey
                                )),
                            // hintText: '9876543210',
                            // hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            // prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            // focusedBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            // enabledBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                            controller: passwordcontroller,
//                        onSaved: (input) => _con.user.password = input,
//                        validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                          onSaved: (value) {
                            //addPasswordToSF(value);
                          },
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return S.of(context).please_enter_password;
                          //   }
                          //   return null; //it means user entered a valid input
                          // },
                          obscureText: obsecuretext,
                          decoration: InputDecoration(
                              labelText: S.of(context).password,
                              labelStyle: TextStyle(color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(5),
                              hoverColor: Colors.black,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecuretext = !obsecuretext;
                                  });
                                },
                                color: Theme.of(context).focusColor,
                                icon: Icon(obsecuretext ? Icons.visibility_off : Icons.visibility,size: 20,color: Colors.grey[400]),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.grey
                                  ))
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height/4.5,//config.App(context).appHeight(37) - 90,
                left: MediaQuery.of(context).size.width / 7,
                right: MediaQuery.of(context).size.width / 7,
                child:  StatefulBuilder(
                    builder: (BuildContext context,state) {
                      buttonstate = state;
                      return LoginButton(email:emailcontroller.text, password:passwordcontroller.text);
                    }
                )
               // LoginButton(email:email, password:password),//Container(color:const Color(0XFFFAFAFA),child: Image.asset('assets/images/LoginImage.png', fit: BoxFit.contain,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,)),
              )
            ],
          ),

        ],
      ),
    ):
   Scaffold(
     // backgroundColor: Colors.pinkAccent,
     backgroundColor:Colors.white,
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: (kIsWeb)?58.0:10,vertical: kIsWeb?50:10),
       child: Container(
         color: Colors.white,
         child: Center(
           child: Row(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Card(
                     elevation: 0,
                     margin: const EdgeInsets.all(0),
                     shadowColor: const Color(0XFFE7EFF3),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 60),
                       child: SingleChildScrollView(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             // Center(
                             //   child: Container(
                             //       // width: 150,
                             //       height: 50,
                             //         padding:EdgeInsets.only(bottom: 5.0),
                             //       /*decoration: BoxDecoration(
                             //           color: Colors.red,
                             //           borderRadius: BorderRadius.circular(50.0)),*/
                             //       child: Image.asset('assets/images/logo.png', fit: BoxFit.fill,)),
                             // ),
                             Padding(
                               padding: const EdgeInsets.only(top:12.0),
                               child:  Text(S.of(context).welcome,style: TextStyle(color: Colors.black,fontSize:25,fontWeight: FontWeight.bold)),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(bottom: 10.0),
                               child:  Text(S.of(context).please_sign,style: TextStyle(color: Colors.grey,fontSize:11,fontWeight: FontWeight.normal)),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                               child:  Text(S.of(context).email,style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                             ),
                             SizedBox(
                               height: 40,
                               child: TextFormField(controller: emailcontroller,
                                 // focusNode: FocusNode(),
                                 textInputAction: TextInputAction.next,

                                 decoration: InputDecoration(

                                   fillColor: Colors.white, filled: true,
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(1.0),
                                     borderSide: BorderSide(
                                       color: Color(0XFFE8E8E8),
                                       width: 1.0,
                                     ),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(1.0),
                                     borderSide: BorderSide(
                                       color: Color(0XFFE8E8E8),
                                     ),
                                   ),

                                   hintText: S.of(context).mai,
                                   hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade400,fontWeight: FontWeight.normal),),

                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top:14.0,bottom: 10.0),
                               child:  Text(S.of(context).password,style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold)),
                             ),
                             SizedBox(
                               height: 40,
                               child: TextFormField(
                                 obscureText: true,
                                 // focusNode: FocusNode(),
                                 textInputAction: TextInputAction.next,
                                 controller: passwordcontroller,
                                 decoration: InputDecoration(
                                   fillColor: Colors.white, filled: true,
                                   enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(1.0),
                                     borderSide: BorderSide(
                                       color: Color(0XFFE8E8E8),
                                       width: 1.0,
                                     ),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(1.0),
                                     borderSide: BorderSide(
                                       color: Color(0XFFE8E8E8),
                                     ),
                                   ),

                                   hintText: S.of(context).enter,
                                   hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey.shade400,fontWeight: FontWeight.normal),),
                               ),
                             ),
                             // SizedBox(height:12),
                             StatefulBuilder(
                                 builder: (BuildContext context,state) {
                                   buttonstate = state;
                                   return LoginButton(email:email, password:password);
                                 }
                             )

                             // LoginButton(email: "email", password: "password")
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
               if(!LayoutView(context).isMobile)
                 Expanded(
                   flex: 1,
                   child: Container(color:const Color(0XFFFAFAFA),child: Image.asset('assets/images/LoginImage.png', fit: BoxFit.contain,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,)),
                 )
             ],
           ),
         ),
       ),
     ),
   );


  }
}
