import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e2portal/api/repository/api_auth_repository.dart';
import 'package:e2portal/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
//State
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}


class AuthenticationAuthenticatedParent extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class UnauthenticatedMessage extends AuthenticationState {
  final String message;

  UnauthenticatedMessage({@required this.message}) : assert(message != null);

}

//Event
class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final Token token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {}


//Bloc
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiAuthRepository apiAuthRepository;

  AuthenticationBloc({@required this.apiAuthRepository}) : assert(apiAuthRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    final bool hasToken = await apiAuthRepository.hasToken();
    final bool isParent = await apiAuthRepository.isParent();
    if (event is AppStarted) {
      if (hasToken) {
        if(isParent){
          yield AuthenticationAuthenticatedParent();
        }else{
          yield AuthenticationAuthenticated();
        }
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await apiAuthRepository.persistToken(event.token);
      if(isParent){
        yield AuthenticationAuthenticatedParent();
      }else{
        yield AuthenticationAuthenticated();
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await apiAuthRepository.removeToken();
      yield AuthenticationUnauthenticated();
    }
  }
}

