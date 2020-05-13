import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loginapp/Common/failure.dart';
import 'package:loginapp/Features/Login/BLoC/login_action.dart';
import 'package:loginapp/Features/Login/BLoC/login_page_bloc.dart';
import 'package:loginapp/Features/Login/BLoC/login_state.dart';
import 'package:loginapp/Features/Login/login_usecase.dart';
import 'package:loginapp/Repository/login_repository.dart';
import 'package:mockito/mockito.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {

}

void main() {
  MockLoginUsecase mockLoginUsecase;
  LoginPageBloc bloc;
  
  setUp((){
    mockLoginUsecase = MockLoginUsecase();
    bloc = LoginPageBloc(loginUsecase: mockLoginUsecase);
  });

  tearDown((){
    bloc.close();
  });
  
  test('BloC EmailInvalidState for ValidateEmail action with "test" as param', () {
    Either<Failure,String> test = left(Failure("invalid"));
    when(mockLoginUsecase.validateEmail("text")).thenReturn(test);

    bloc.add(ValidateEmail(email: "text"));

    var expectedResponse =  [DefaultState(), EmailInvalidState()];
    expectLater(
       bloc,
       emitsInOrder(expectedResponse),
    );
  });

  test('BloC does not emit any event for ValidateEmail action with valid "asd@asd.com" as param', () {
    String email =  'asd@asd.com';
    Either<Failure,String> test = right(email);
    when(mockLoginUsecase.validateEmail(email)).thenReturn(test);
   
    bloc.add(ValidateEmail(email: email));

    var expectedResponse =  [DefaultState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });

  test('BloC emits PasswordInvalidState for ValidatePassword action with Empty text '' as param', () {
    String pwd =  '';
    Either<Failure,String> test = left(Failure("invalid"));
    when(mockLoginUsecase.validatePassword(pwd)).thenReturn(test);

    bloc.add(ValidatePassword(pwd: pwd));

    var expectedResponse =  [DefaultState(),PasswordInvalidState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });

  test('BloC does not emit for ValidatePassword action with valid password as param', () {
    String pwd =  'Password';
    Either<Failure,String> test = right(pwd);
    when(mockLoginUsecase.validatePassword(pwd))
        .thenReturn(test);

    bloc.add(ValidatePassword(pwd: pwd));

    var expectedResponse =  [DefaultState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });


  test('BloC emits EmailInvalidState for LoginAction action with invalid email param', () {
    String email =  '';
    var loginAction = LoginAction(email: email,pwd: "");
    Either<Failure,String> test = left(Failure("invalid"));
    when(mockLoginUsecase.validateEmail(email))
        .thenReturn(test);
    
    bloc.add(loginAction);
    
    var expectedResponse =  [DefaultState(),EmailInvalidState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });

  test('BloC emits EmailInvalidState for LoginAction action with invalid pwd param and vaild email', () {
    String pwd =  '';
    String email =  "asd@asd.com";
    var loginAction = LoginAction(email: email,pwd: pwd);
    Either<Failure,String> test = left(Failure("invalid"));
    when(mockLoginUsecase.validateEmail(email))
        .thenReturn(right(email));
    when(mockLoginUsecase.validatePassword(pwd))
        .thenReturn(test);
    
    bloc.add(loginAction);

    var expectedResponse =  [DefaultState(),PasswordInvalidState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });


  test('BloC emits LoginLoadingState followed by LoginFailureState for LoginAction action with invalid pwd and email', () {
    String pwd =  'pwd';
    String email =  "test";
    var loginAction = LoginAction(email: email,pwd: pwd);
    Either<Failure,Login> returnVal = left(Failure("invalid"));
    when(mockLoginUsecase.validateEmail(email))
        .thenReturn(right(email));
    when(mockLoginUsecase.validatePassword(pwd))
        .thenReturn(right(pwd));
    Future<Either<Failure,Login>> loginFailedFuture = Future.value(returnVal);
    when(mockLoginUsecase.login(email, pwd))
        .thenAnswer((_) => loginFailedFuture);
    
    bloc.add(loginAction);

    var expectedResponse =  [DefaultState(),LoginLoadingState(),LoginFailureState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });

  test('BloC emits LoginLoadingState followed by LoginSuccessState for LoginAction action with valid pwd and email', () {
    String pwd =  'pwd';
    String email =  "asd@asd.com";
    var loginAction = LoginAction(email: email,pwd: pwd);
    when(mockLoginUsecase.validateEmail(email)).thenReturn(right(email));
    when(mockLoginUsecase.validatePassword(pwd)).thenReturn(right(pwd));
    Either<Failure,Login> returnVal = right(Login()..token= "token");
    Future<Either<Failure,Login>> loginFailedFuture = Future.value(returnVal);
    when(mockLoginUsecase.login(email, pwd)).thenAnswer((_) => loginFailedFuture);

    bloc.add(loginAction);

    var expectedResponse =  [DefaultState(),LoginLoadingState(),LoginSuccessState()];
    expectLater(
      bloc,
      emitsInOrder(expectedResponse),
    );
  });

}