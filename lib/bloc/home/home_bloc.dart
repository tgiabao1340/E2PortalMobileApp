import 'package:bloc/bloc.dart';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/data/shared_preferences_manager.dart';
import 'package:e2portal/injector/injector.dart';
import 'package:e2portal/model/student/student.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../blocs.dart';

//State
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState{
  final Student student;

  HomeLoaded({@required this.student}) :assert(student!= null);
}
class HomeFailure extends HomeState {
  final String error;

  HomeFailure({@required this.error});
}

//Event
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeRequest extends HomeEvent {
  @override
  List<Object> get props => [];
}
//Bloc process
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiProfileRepository apiProfileRepository;
  final AuthenticationBloc authenticationBloc;

  HomeBloc({@required this.apiProfileRepository, @required this.authenticationBloc}) : assert(apiProfileRepository != null), assert(authenticationBloc != null);

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeRequest) {
      yield HomeLoading();
      try {
        final student = await apiProfileRepository.getStudent();
        if (student.error != null) {
          print(student.error.toString());
          throw student.error;
        }
        yield HomeLoaded(student: student);
      } catch (error) {
        authenticationBloc.add(LoggedOut());
        print(error);
        yield HomeFailure(error: error.toString());
      }
    }
  }
}
