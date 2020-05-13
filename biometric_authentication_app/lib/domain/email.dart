
import 'package:loginapp/common/failure.dart';
import 'package:loginapp/common/form_entry.dart';


class Email extends FormEntry<String,_EmailValidator>{
  Email(String data) : super(data,_EmailValidator(emailId: data));

}

class _EmailValidator implements Validator {

  String _emailId;
  _EmailValidator({String emailId}){
    _emailId = emailId;
  }

  Failure validate() {
    if (_emailId.isEmpty) {
      return Failure('empty_email');
    }
    if (!_validateId(_emailId)){
      return Failure('invalid_email');
    }
    return null;
  }

  bool _validateId(String emailId) {
    String pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(emailId);
  }
}