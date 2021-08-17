import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app_hivedb/model/description.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app_hivedb/pages/home_page.dart';
import 'package:movie_app_hivedb/pages/main_page.dart';
import 'package:movie_app_hivedb/pages/pre_homepage.dart';
import 'package:movie_app_hivedb/services/helperfunction.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DescriptionAdapter());
  await Hive.openBox<Description>('descriptions');
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userLoggedIn = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourMovies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userLoggedIn ? MainPage() : PreHomePage(),
    );
  }
}
