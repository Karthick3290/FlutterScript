import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/common/failure.dart';

class BiometricService{
  final LocalAuthentication auth = LocalAuthentication();
  String localiseReason = '';
  bool useErrorDialogs = true;
  bool stickyAuth = true;
  bool get  isAuthenticating => _isAuthenticating;
  bool _isAuthenticating = false;

  Future<Either<Failure,bool>> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return Left(Failure(e.code));
    }
    return Right(canCheckBiometrics);
  }

  Future<Either<Failure,List<BiometricType>>> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return Left(Failure(e.code));
    }
    return right(availableBiometrics);
  }

  Future<Either<Failure,bool>> authenticate() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: localiseReason,
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth);
    } on PlatformException catch (e) {
      print(e);
      _isAuthenticating = false;
      return left(Failure(e.code));
    }
    _isAuthenticating = false;
    return right(authenticated);
  }

  void cancelAuthentication() {
    auth.stopAuthentication();
  }

}