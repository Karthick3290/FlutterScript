import 'package:flutter/material.dart';

import 'features/login/presentation/login_view.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioMetricVerification',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(body: LoginPage(title: 'Login')),
    );
  }
}

