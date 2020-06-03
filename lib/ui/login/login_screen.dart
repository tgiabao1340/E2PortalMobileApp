import 'package:e2portal/api/repository/api_auth_repository.dart';
import 'package:e2portal/app_config.dart';
import 'package:e2portal/bloc/blocs.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/router.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiAuthRepository apiAuthRepository = new ApiAuthRepository();
  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _validate = false;
  DateTime currentBackTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
        }
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context), apiAuthRepository: apiAuthRepository);
          },
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Scaffold(
                  body: BlocProvider<LoginBloc>(
                    create: (context) {
                      return LoginBloc(
                          apiAuthRepository: apiAuthRepository,
                          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
                    },
                    child: WillPopScope(
                      onWillPop: onWillPop,
                      child: AnnotatedRegion<SystemUiOverlayStyle>(
                        value: SystemUiOverlayStyle.light,
                        child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppTheme.BACKGROUND,
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40.0,
                                    vertical: 120,
                                  ),
                                  child: Form(
                                    key: _globalKey,
                                    autovalidate: _validate,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('E2Portal', style: AppTheme.LogoTextStyle),
                                        SizedBox(height: 40.0),
                                        CustomTextField(
                                          label: 'Mã Sinh viên',
                                          prefixIcon: Icons.account_circle,
                                          controller: _idController,
                                          hint: 'Nhập mã sinh viên',
                                          validator: validateId,
                                          keyboardType: TextInputType.number,
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        CustomTextField(
                                          label: 'Mật khẩu',
                                          prefixIcon: Icons.lock,
                                          controller: _passwordController,
                                          obscureText: true,
                                          hint: 'Nhập mật khẩu',
                                          validator: validatePassword,
                                          keyboardType: TextInputType.text,
                                        ),
                                        _buildLoginBtn(context, state),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: state is LoginLoading ? CardLoading() : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn(context, state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: CustomButton(
        text: 'Đăng Nhập',
        onPressed: () {
          if (_globalKey.currentState.validate()) {
            _globalKey.currentState.save();
            if (state is! LoginLoading) {
              BlocProvider.of<LoginBloc>(context)
                  .add(LoginRequest(loginBody: LoginBody(id: _idController.text, password: _passwordController.text)));
            }
          } else {
            setState(() {
              _validate = true;
            });
          }
        },
      ),
    );
  }

  String validateId(String id) {
    if (id.isEmpty) return 'Mã số không được để trống';
    if (id.length != 8) return 'Mã số gồm 8 số';
    return null;
  }

  String validatePassword(String password) {
    if (password.isEmpty) return 'Mật khẩu không được đễ trống';
    if (password.length < 6) return 'Mật khẩu không được ít hơn 6 ký tự';
    return null;
  }

  displayDialog(context, title, text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackTime == null || now.difference(currentBackTime) > Duration(seconds: 2)) {
      currentBackTime = now;
      Fluttertoast.showToast(msg: "Nhấn lần nữa để thoát");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
