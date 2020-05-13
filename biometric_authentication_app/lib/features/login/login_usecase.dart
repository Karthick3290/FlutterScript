import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginapp/common/failure.dart';
import 'package:loginapp/domain/email.dart';
import 'package:loginapp/domain/password.dart';
import 'package:loginapp/repository/login_repository.dart';

class LoginUsecase {
  LoginRepository _loginRepository;

  LoginUsecase({@required LoginRepository loginRepository}) {
    this._loginRepository = loginRepository;
  }


  Either<Failure,String> validateEmail (String email) {
    Email e = Email(email);
    return e.value;
  }


  Either<Failure,String> validatePassword (String password) {
   Password p = Password(password);
   return p.value;
  }

  Future<Either<Failure,Login>> login(String email, String pwd) async {
   return  _loginRepository.authenticate(username: email, password: pwd);
  }
}