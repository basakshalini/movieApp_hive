import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_hivedb/provider/google_sign_in.dart';
import 'package:movie_app_hivedb/widgets/logged_in_widget.dart';
import 'package:movie_app_hivedb/widgets/sign_up_widget.dart';

import 'package:provider/provider.dart';

class PreHomePage extends StatelessWidget {
  const PreHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);

              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return LoggedInWidget();
              } else {
                return SignUpWidget();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          
          
          Center(child: CircularProgressIndicator()),
        ],
      );
}