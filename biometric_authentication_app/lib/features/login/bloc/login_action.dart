import 'package:flutter/cupertino.dart';

abstract class LoginPageEvent {}

class ValidateEmail extends LoginPageEvent {
  String email;
  ValidateEmail({@required this.email});
}

class ValidatePassword extends LoginPageEvent {
  String pwd;
  ValidatePassword({@required this.pwd});
}

class LoginAction extends LoginPageEvent {
  String email;
  String pwd;
  LoginAction({@required this.email,@required this.pwd}) ;
}