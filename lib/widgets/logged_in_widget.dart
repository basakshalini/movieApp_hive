import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_hivedb/pages/main_page.dart';
import 'package:movie_app_hivedb/provider/google_sign_in.dart';

import 'package:provider/provider.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    bool isLoggedIn = true;
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Logged In as ' + (user!.email).toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 8),
          // CircleAvatar(
          //   maxRadius: 25,
          //   backgroundImage: NetworkImage((user!.photoURL).toString() ),
          // ),
          // SizedBox(height: 8),
          // Text(
          //   'Name: ' + (user.displayName).toString(),
          //   style: TextStyle(color: Colors.white),
          // ),
          // SizedBox(height: 8),
          // Text(
          //   'Email: ' + (user.email).toString(),
          //   style: TextStyle(color: Colors.white),
          // ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              ButtonTheme(
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => MainPage()));
                    },
                    child: Text('Continue as ' + (user.displayName).toString()),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(width: 20),
              ButtonTheme(
                child: RaisedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                    child: Text('Logout'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
