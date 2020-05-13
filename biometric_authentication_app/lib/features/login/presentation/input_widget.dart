import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final InputAttributes inputAttributes;

  const InputWidget({Key key, @required this.inputAttributes})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}


/// Input Widget
/// todo:: figure out architecture behind this.
class InputAttributes {
  final String _title;
  final String _hint;
  final bool _isObscured;
  final TextEditingController _textEditController;

  InputAttributes(
      this._title, this._hint, this._isObscured, this._textEditController);
}


class _InputState extends State<InputWidget> {
  final double _textSize = 32.0;
  final double _secondaryTextSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${widget.inputAttributes._title}',
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blueGrey[50],
              fontSize: _textSize,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.normal),
        ),
        TextField(
          controller: widget.inputAttributes._textEditController,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.blueGrey[50],
              fontSize: _secondaryTextSize,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal),
          obscureText: widget.inputAttributes._isObscured,
          cursorColor: Colors.white30,
          decoration: InputDecoration(
            hintText: '${widget.inputAttributes._hint}',
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: Colors.blueGrey[200],
                fontSize: _secondaryTextSize,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
        ),
      ],
    );
  }
}
