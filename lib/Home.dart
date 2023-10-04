import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_combo_box/flutter_combo_box.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "HomePage" ;

  @override
  Home createState() => Home();
}

class Home extends State<HomeScreen> {

  var database = FirebaseDatabase.instance.ref();
  String userType = "Seller";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          elevation: 0,
          actions: [
            PopupMenuButton(
              iconSize: 40,
              onSelected: (value) {
                if(value == 1) {
                 // Navigator.pushNamed(context, LoginForm.routeName);
                }
                else if(value == 2) {
                  //Navigator.pushNamed(context, LoginForm.routeName);
                }
                else if(value == 3) {
                 // Navigator.pushNamed(context, LoginForm.routeName);
                }
                else if(value == 4) {
                 // Navigator.pushNamed(context, LoginForm.routeName);
                }
              },
              icon: Icon(Icons.menu),
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: Text('Page 1')
                ),
                PopupMenuItem(
                    value: 2,
                    child: Text('Page 2')
                ),
                PopupMenuItem(
                    value: 3,
                    child: Text('Page 3')
                ),
                PopupMenuItem(
                    value: 4,
                    child: Text('Page 4')
                ),
              ],
            ),
          ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 180,
            child: Image(
                image: AssetImage('assets/images/Dolphin.png')
            ),
          ),
          Text(
            "The Acquires",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ],
      )),
    );
  }


}

