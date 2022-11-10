import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../core/util/presentation/controller/onpress_controller.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/get_profile_modle.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/customers/userprofile_bloc.dart';

class CustomerProfileButton extends StatelessWidget {
  final CustomerData userdata;

  CustomerProfileButton({Key? key,required this.userdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child:
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icons/profile.png",height: 45,width: 45),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(userdata.username!,style: TextStyle(color: Colors.black,fontSize:15,fontWeight: FontWeight.bold)),
                  Text("#${userdata.mobileNumber}",style: TextStyle(color: Colors.grey,fontSize:12,fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(right:10.0),
              //   child: Image.asset("assets/icons/edit.png",height: 18,width: 18),
              // ),
              GestureDetector(
                onTap: () {
                  sl<SharedPreferences>().setBool(Prefrence.showSearchbar, false);
                  // deleteItem(currentindex);
                  BlocProvider.of<UserProfileBloc>(context).add(ClearCustomerData(userdata.apiKey!));
                  BlocProvider.of<CartItemBloc>(context).add(const ClearCart());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:13.0),
                  child: Column(
                    children: [
                      Image.asset("assets/icons/deletecircle.png",height: 22,width: 22)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
