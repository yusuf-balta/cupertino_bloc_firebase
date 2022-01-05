import 'package:cupertione_flutter/scrren/home_page/home_page.dart/home_page.dart';
import 'package:cupertione_flutter/scrren/landing_page/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: auth.currentUser == null ? const LandingPage() : const HomePage(),
    );
  }
}
