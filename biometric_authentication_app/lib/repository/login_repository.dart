import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginapp/common/failure.dart';

class Login {
  String token;
}

class LoginRepository {
  Future<Either<Failure,Login>> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return right(Login()..token = "token");
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 100));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}