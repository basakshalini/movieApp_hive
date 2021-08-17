import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:movie_app_hivedb/provider/google_sign_in.dart';
import 'package:movie_app_hivedb/services/helperfunction.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Text('YourMovies App',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          SizedBox(
            height: 10,
          ),
          Image.asset('assets/logo.png'),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: OutlineButton.icon(
              label: Text(
                'Sign In With Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              highlightedBorderColor: Colors.black,
              borderSide: BorderSide(color: Colors.black),
              textColor: Colors.black,
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.blue),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
                HelperFunction.saveUserLoggedInSharedPreference(true);
                //HelperFunction.saveUserNameSharedPreference(user.)
              },
            ),
          ),
        ],
      );
}
