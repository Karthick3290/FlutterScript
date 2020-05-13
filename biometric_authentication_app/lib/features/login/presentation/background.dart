import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueGrey[900],
            Colors.blueGrey[800],
            Colors.blueGrey[700],
            Colors.blueGrey[500]
          ],
        ),
      ),
    );
  }
}