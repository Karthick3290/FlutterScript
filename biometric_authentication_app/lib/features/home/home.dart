import 'package:flutter/material.dart';
import 'package:loginapp/features/home/authentication_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: AuthenticationWidget(),
//        child: RaisedButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
      ),
    );
  }
}