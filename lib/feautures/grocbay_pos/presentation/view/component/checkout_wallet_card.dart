import 'package:flutter/material.dart';
class CheckoutWallet extends StatefulWidget {
  final String w_type;
  final double Balance;
  const CheckoutWallet({Key? key,required this.w_type, required this.Balance}) : super(key: key);

  @override
  _CheckoutWalletState createState() => _CheckoutWalletState();
}

class _CheckoutWalletState extends State<CheckoutWallet> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      widget.w_type=="wallet"?
                            Image.asset("assets/icons/money.png",height: 25,width: 25)
                          : Image.asset("assets/icons/loyalty.png",height: 25,width: 25)

                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.w_type=="wallet"?Text("Grossbay Wallet",style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)):Text("Loyalty",style: TextStyle(color: Colors.black,fontSize:10,fontWeight: FontWeight.bold)),
                        widget.w_type=="wallet"?Text("Wallet Balence ₹"+widget.Balance.toString(),style: TextStyle(color: Colors.grey,fontSize:8,fontWeight: FontWeight.bold)):Text(''),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text("₹"+widget.Balance.toString(),style: TextStyle(color: Colors.green,fontSize:12,fontWeight: FontWeight.bold)),
                      Checkbox(value: false, onChanged:null,checkColor: Colors.green,activeColor: Colors.green,)
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
