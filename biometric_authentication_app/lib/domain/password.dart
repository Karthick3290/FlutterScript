import 'package:loginapp/common/failure.dart';

import '../common/form_entry.dart';

class Password extends FormEntry<String, _PasswordValidator>{
  Password(String data) : super(data,_PasswordValidator(password: data));
}

class _PasswordValidator implements Validator {

  String _password;

  _PasswordValidator({String password}){
    _password = password;
  }

  Failure validate() {
    if (_password.isEmpty) {
      return Failure('empty_email');
    }
    if (!_validatePwd()){
      return Failure('invalid_email');
    }
    return null;
  }

  bool _validatePwd() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(_password);
  }
}