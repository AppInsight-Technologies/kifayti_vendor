import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/util/presentation/constants/ic_constants.dart';
import '../../../../../../core/util/presentation/styles/screen_size_rario.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/entities/getAllCountModel.dart';
import '../../../bloc/getAllCount/get_All_Count_bloc.dart';
import '../../widgte/sales_data.dart';

class DeleveryAnalitics extends StatefulWidget {
  const DeleveryAnalitics({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleveryAnalitics> createState() => _DeleveryAnaliticsState();
}

class _DeleveryAnaliticsState extends State<DeleveryAnalitics> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetAllCountBloc>(context).add(OnGetAllCountEvent(sl<SharedPreferences>().getString(Prefrence.BRANCH)??''));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        BlocBuilder<GetAllCountBloc, GetAllCountState>(
          builder: (context, state) {
            // if(state is GetAllCountLoading){
            //   return Center(child: CircularProgressIndicator());
            // }
            if(state is GetAllCountSucsess<List<PosGetAllCount>>) {
              return   SizedBox(
                width: MediaQuery.of(context).size.width,
                height:(LayoutView(context).isWeb || LayoutView(context).isTab)?80:150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation: 2,child:  SalesData(ic_color: Color(0xffF3853B),text: "Home Delivery",count: state.data.first.homedeliveriescount)),
                    )),
                     Expanded(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(elevation: 2,child: SalesData(ic_color:  Color(0xff37BD6A),text: "Express Delivery",count: state.data.first.expressorderscount)),
                    )),
                     Expanded(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(elevation: 2,child: SalesData(ic_color:  Color(0xff2A3864),text: "Pick up from Store",count:state.data.first.pickuporderscount)),
                    )),
                   /* Expanded(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(elevation: 2,child: SalesData(ic_color: Colors.blueAccent,text: "Instore Order",count:state.data.first.instoreorderscount)),
                    )),*/
                    //   SalesData(data: SalesDataModle(s_value:0.00 ), s_type:'GROSS PROFIT' , s_color:Colors.blue.shade900,ic_image: "assets/icons/icon.png", type: Datatype.Perc),
                    //   SalesData(data: SalesDataModle(s_value:180.24), s_type:'AVERAGE SALE VALUE' , s_color:Colors.lightBlue,ic_image: "assets/icons/icon3.png",type: Datatype.Rs,),
                    //   SalesData(data: SalesDataModle(s_value:12), s_type:'NEW CUSTOMERS' , s_color:Colors.black,ic_image: "assets/icons/icon4.png",type: Datatype.Count,),
                  ],
                ),
              );
            }

            else{
              return SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}