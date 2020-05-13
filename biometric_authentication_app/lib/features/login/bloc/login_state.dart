import 'package:equatable/equatable.dart';

class LoginBaseState extends Equatable {
  const LoginBaseState();

  @override
  List<Object> get props => [];
}
class DefaultState extends LoginBaseState {}
class LoginLoadingState extends LoginBaseState {}
class LoginSuccessState extends LoginBaseState {}
class LoginFailureState extends LoginBaseState {}
class EmailInvalidState extends LoginBaseState {}
class PasswordInvalidState extends LoginBaseState {}
class NavigateToNextView extends LoginBaseState {}