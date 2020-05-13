
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/common/failure.dart';
import 'package:loginapp/repository/login_repository.dart';

import '../login_usecase.dart';
import 'login_action.dart';
import 'login_state.dart';


class LoginPageBloc extends Bloc<LoginPageEvent,LoginBaseState> {
  
  LoginUsecase _loginUsecase;

  LoginPageBloc({@required LoginUsecase loginUsecase}) {
    assert(loginUsecase != null);
    _loginUsecase = loginUsecase;
  }

  @override
  // TODO: implement initialState
  LoginBaseState get initialState => DefaultState();

  @override
  Stream<LoginBaseState> mapEventToState(LoginPageEvent event) async* {

    if (event is ValidateEmail) {
      var result = _loginUsecase.validateEmail(event.email);
      if (result.isLeft()) {
        yield EmailInvalidState();
      }
    }
    
    if (event is ValidatePassword) {
      var result = _loginUsecase.validatePassword(event.pwd);
      if (result.isLeft()) {
        yield PasswordInvalidState();
      }
    }

    if (event is LoginAction) {
      yield* handleLoginAction(event);
    }
  }

  Stream<LoginBaseState> handleLoginAction(LoginAction event) async* {
    var emailResult = _loginUsecase.validateEmail(event.email);
    var passwordResult = _loginUsecase.validatePassword(event.pwd);

    var loginValidationPassed = true;
    if(emailResult.isLeft()) {
      loginValidationPassed = false;
      yield EmailInvalidState();
    }
    else if(passwordResult.isLeft()) {
      loginValidationPassed = false;
      yield PasswordInvalidState();
    }

    if (loginValidationPassed) {
      yield LoginLoadingState();
      assert(_loginUsecase != null);
      Either<Failure, Login> result = await _loginUsecase.login(
          event.email, event.pwd);
      LoginBaseState state;
      result.fold((failure) {
        state = LoginFailureState();
      }, (data) {
        state = LoginSuccessState();
      });
      yield state;
    }
  }

}



