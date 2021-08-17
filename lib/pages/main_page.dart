import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app_hivedb/model/description.dart';

import 'package:movie_app_hivedb/pages/home_page.dart';
import 'package:movie_app_hivedb/pages/pre_homepage.dart';
import 'package:movie_app_hivedb/widgets/logged_in_widget.dart';
import 'package:movie_app_hivedb/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:movie_app_hivedb/provider/google_sign_in.dart';

import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
  // final String username;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   openBox();
  //   super.initState();
  // }

  // void openBox() async {
  //   await Hive.initFlutter();
  //   Hive.registerAdapter(DescriptionAdapter());
  //   await Hive.openBox<Description>('descriptions');
  // }

  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();
    final user = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = true;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        title: Center(child: appBar(context, 'Your', 'Movies')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/2.gif',
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(width: 28),
              Text(
                'Hello User',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: "Nunito",
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(width: 28),
              Text(
                'Go on and add your favorite movies to your list!\nEnjoy more features \nto edit and delete the ones you wish.\nYou are now logged in.',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Nunito",
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // Center(
          //   child: Text(
          //     'Logged In as ' + (user!.email).toString(),
          //     style: TextStyle(color: Colors.black, fontSize: 13),
          //   ),
          // ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Image.asset(
                'assets/gif3.gif',
                height: 150,
              ),
              SizedBox(
                width: 20,
              ),
              ButtonTheme(
                minWidth: 10,
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HomePage()));
                      },
                      child: Text(
                        'Create My List',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Nunito",
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        // await googleSignIn.disconnect();
                        // FirebaseAuth.instance.signOut();
                        //Hive.close();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => PreHomePage()));
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Nunito",
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
