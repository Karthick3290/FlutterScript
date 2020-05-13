import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/features/home/home.dart';
import 'package:loginapp/features/login/bloc/login_action.dart';
import 'package:loginapp/features/login/bloc/login_state.dart';
import 'package:loginapp/repository/login_repository.dart';

import '../bloc/login_page_bloc.dart';
import '../login_usecase.dart';
import 'background.dart';
import 'input_widget.dart';
import 'loading_indicator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  LoginPageBloc _loginPageBloc = LoginPageBloc(
      loginUsecase: LoginUsecase(loginRepository: LoginRepository()));

  @override
  void initState() {
    super.initState();
  }

  _LoginState();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginPageBloc,
      listener: (context, LoginBaseState state) {
        if (state is EmailInvalidState) {
          final snackBar = SnackBar(content: Text('Invalid email'));

          Scaffold.of(context).showSnackBar(snackBar);
        }
        if (state is PasswordInvalidState) {
          final snackBar = SnackBar(content: Text('Invalid passsword'));

          Scaffold.of(context).showSnackBar(snackBar);
        }

        if (state is LoginSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      },
      child: BlocBuilder(
          bloc: _loginPageBloc,
          builder: (context, LoginBaseState state) {
            var main = _getChild(context, state);
            if (state is LoginLoadingState) {
              return Stack(children: <Widget>[
                main,
                LoadingIndicator(),
              ]);
            } else {
              return main;
            }
          }),
    );
  }

  Scaffold _getChild(BuildContext context, LoginBaseState state) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundWidget(),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputWidget(
                    inputAttributes: InputAttributes("E-mail",
                        "johndoe@xyz.org", false, _usernameTextController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    inputAttributes: InputAttributes("Password",
                        "Enter password", true, _passwordTextController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    disabledColor: Colors.blueGrey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(
                            color: Colors.blueGrey[50],
                            style: BorderStyle.none)),
                    color: Colors.blueGrey[50],
                    textColor: Colors.blueGrey[800],
                    padding: EdgeInsets.all(8.0),
                    onPressed: _onLoginPressed,
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(Icons.navigate_next)
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onLoginPressed() {
    _loginPageBloc.add(LoginAction(
        email: _usernameTextController.text,
        pwd: _passwordTextController.text));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
  }
}
