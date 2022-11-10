
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/create-profile_model.dart';
import '../../bloc/customers/Register/register_bloc.dart';
import '../../bloc/customers/userprofile_bloc.dart';
import 'dailog/alert _dailog.dart';

class CreateProfile extends StatefulWidget {
  final String? initnum;

  const CreateProfile({Key? key,this.initnum}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  int _selectedGender = 0;
  late TextEditingController firstnamecontroller;
  late TextEditingController lastnamecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController mobilenumcontroller;
  late TextEditingController locationcontroller;

  String firstname="";
  String lastname="";
  String email="";
  String mobilenum="";
  String location="";
  String fullname="";
  String tokenId="";
  String device="POS";
  String path="";
  String referralid="";
  String branch="4";

  late Function(void Function() p1) buttonstate;

  FocusNode focusphone = FocusNode();
  FocusNode focusemail = FocusNode();
  FocusNode focusname = FocusNode();
  FocusNode focussubmit = FocusNode();
  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  @override
  void initState() {
    firstnamecontroller = TextEditingController(text: "");
    lastnamecontroller = TextEditingController(text: "");
    emailcontroller = TextEditingController(text: "");
    mobilenumcontroller = TextEditingController(text: widget.initnum!=null?"${widget.initnum}":"");
    locationcontroller = TextEditingController(text: "");
    setState(()=>  mobilenum = widget.initnum!=null?widget.initnum!:"");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    firstnamecontroller.addListener(() {
      buttonstate(() {
        firstname = firstnamecontroller.value.text;
      });
    });
    lastnamecontroller.addListener(() {
      buttonstate(() {
        lastname = lastnamecontroller.value.text;
      });
    });
    emailcontroller.addListener(() {
      buttonstate(() {
        email = emailcontroller.value.text;
      });
    });
    mobilenumcontroller.addListener(() {
      buttonstate(() {
        mobilenum = mobilenumcontroller.value.text;
      });
    });
    locationcontroller.addListener(() {
      buttonstate(() {
        location = locationcontroller.value.text;
      });
    });
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child:  Text(S.current.Profile,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
           Text(S.of(context).create_personal,style: TextStyle(color: Colors.grey,fontSize: 12),),
         /* SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Male',style:TextStyle(fontWeight: FontWeight.bold),),
              Radio<int>(
                activeColor: Colors.green,
                value: 0,
                groupValue:_selectedGender,
                onChanged: (val) {
                  setState(() {
                    _selectedGender = val as int;
                  });
                },
              ),
              SizedBox(width:15),
              const Text('Female',style:TextStyle(fontWeight: FontWeight.bold),),
              Radio<int>(
                activeColor: Colors.green,
                value: 1,
                groupValue:_selectedGender,
                onChanged: (val) {
                  setState(() {
                    _selectedGender = val as int;
                  });
                },
              ),

            ],
          ),*/
          const SizedBox(height:5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(S.of(context).mobile_number,style: TextStyle(color: Colors.black26,fontSize: 12),),
                      TextFormField(controller: mobilenumcontroller,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        focusNode: focusphone,
                        onFieldSubmitted: (val)=>focusname.requestFocus(),
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade50, filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1.0,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /*Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Location",style: TextStyle(color: Colors.grey,fontSize: 9),),
                        TextFormField(controller: locationcontroller,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade50, filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),*/
            ],
          ),
          const SizedBox(height:15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(S.of(context).email_opt,style: TextStyle(color: Colors.black26,fontSize: 12),),
                TextFormField(controller: emailcontroller,
                  focusNode: focusname,
                  onFieldSubmitted: (val)=>focusemail.requestFocus(),
                  decoration: InputDecoration(

                    fillColor: Colors.grey.shade50, filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
            const SizedBox(height:15),
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(S.of(context).name_opt,style: TextStyle(color: Colors.black26,fontSize: 12),),
                        TextFormField(controller: firstnamecontroller,
                          focusNode: focusemail,
                          onFieldSubmitted: (val)=>focussubmit.requestFocus(),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade50, filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Last name*",style: TextStyle(color: Colors.grey,fontSize: 9),),
                          TextFormField(controller: lastnamecontroller,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50, filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            const SizedBox(height:15),
            StatefulBuilder(
                builder: (BuildContext context,state) {
                  buttonstate = state;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(

                    height: 40,
                    width:MediaQuery.of(context).size.width/3.4,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: FlatButton(
                      focusNode: focussubmit,
                      // autofocus: true,
                      onPressed: (){
                        debugPrint("clicked");
                        if(firstname == "" || firstname == null){
                          fullname = "Guest User";
                        }else {
                          fullname = firstname;
                        }

                          if(/*firstname == '' || firstname == null || lastname == '' || lastname == null ||*/ mobilenumcontroller.text == '' || mobilenumcontroller.text == null)
                          {
                            Alert().showallert(context,messege: S.of(context).please_enter_the_mandatory_fields);
                          }else if(!_numeric.hasMatch(mobilenumcontroller.text) || mobilenumcontroller.text.length != 10){

                            Alert().showallert(context,messege: S.of(context).please_enter_valid_mobile_number);
                          }
                          else {
                            BlocProvider.of<RegisterBloc>(context).add(OnRegister(fullname, mobilenum, email, tokenId, device, path, sl<SharedPreferences>().getString(Prefrence.BRANCH)!, referralid, _selectedGender));
                          }
                          // Navigator.pop(context);
                        },
                        child: BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if (state is RegisterSucsess<CustomerRegister>) {
                              final statse = state.data;
                              debugPrint("register response"+statse.toString());
                              firstname='';
                              lastname='';
                              mobilenum='';
                              email='';
                              location='';
                              Navigator.pop(context);
                              // Alert().showallert(context,messege: "User Created");
                              VxToast.show(context, msg: S.of(context).Order_Created);
                              BlocProvider.of<UserProfileBloc>(context).add(OnUserProfile (statse.userId.toString()));
                              sl<SharedPreferences>().setBool(Prefrence.showSearchbar, true);
                              //Navigation(context, navigatore:NavigatoreTyp.homenav);
                            }
                            if(state is RegisterError){
                              state.e;
                              Alert().showallert(context,messege: state.e);
                            }
                          },
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return const CircularProgressIndicator();
                            } else {
                              return  Text(
                                S.current.Create,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      );
  }
}
