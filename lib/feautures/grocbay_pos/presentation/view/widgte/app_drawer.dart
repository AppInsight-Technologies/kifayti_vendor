import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget{
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*AppBar(
              title: Text('Hello Friend!'),
              automaticallyImplyLeading: false, // it shouldnt add back button
            ),*/
            Container(
              color: Colors.white,
              child: Column(
                children: [


                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).pop();

                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                         "Lpogin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right,
                            color: Colors.black12,
                            size: 30),
                        SizedBox(
                          width: 25.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}