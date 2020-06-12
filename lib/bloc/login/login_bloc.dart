import 'package:bloc/bloc.dart';
import 'package:e2portal/api/repository/api_auth_repository.dart';
import 'package:e2portal/data/shared_preferences_manager.dart';
import 'package:e2portal/injector/injector.dart';
import 'package:e2portal/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../authenticate/authenticate_bloc.dart';

//State
abstract class LoginState extends Equatable {

  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {

  final String error;

  const LoginFailure({@required this.error});

}

//Event
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequest extends LoginEvent {
  final LoginBody loginBody;
  final bool isParent;

  const LoginRequest({@required this.loginBody, this.isParent});

  @override
  List<Object> get props => [loginBody];

}
//Bloc process
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiAuthRepository apiAuthRepository;
  final AuthenticationBloc authenticationBloc;
  final SharedPreferencesManager sharedPreferencesManager = locator<SharedPreferencesManager>();

  LoginBloc({@required this.apiAuthRepository, @required this.authenticationBloc})
      : assert(apiAuthRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequest) {
      yield LoginLoading();
      try {
        final token = await apiAuthRepository.postLoginUser(event.loginBody);
        if (token.error != null) throw token.error;
        if(event.isParent) sharedPreferencesManager.putBool(SharedPreferencesManager.isParent, true);
        else sharedPreferencesManager.putBool(SharedPreferencesManager.isParent, false);
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }

}