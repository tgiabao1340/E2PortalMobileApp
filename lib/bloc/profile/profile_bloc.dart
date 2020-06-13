import 'package:bloc/bloc.dart';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/bloc/authenticate/authenticate_bloc.dart';
import 'package:e2portal/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//State
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Student student;

  const ProfileLoaded({@required this.student}) : assert(student != null);

  @override
  // TODO: implement props
  List<Object> get props => [student];

}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({@required this.error});
}

class ChangeSuccess extends ProfileState{
}

//Event
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileRequest extends ProfileEvent {
  @override
  List<Object> get props => [];
}
class ChangePassword extends ProfileEvent{
  final String newPassword;

  ChangePassword({@required this.newPassword});

  @override
  List<Object> get props => [newPassword];

}

//Bloc process
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiProfileRepository apiProfileRepository;
  final AuthenticationBloc authenticationBloc;

  ProfileBloc({@required this.apiProfileRepository, @required this.authenticationBloc})
      : assert(apiProfileRepository != null),
        assert(authenticationBloc != null);
  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileRequest) {
      yield ProfileLoading();
      try {
        final student = await apiProfileRepository.getStudent();
        if (student.error != null ) throw student.error;
          yield ProfileLoaded(student: student);
      } catch (error) {
        authenticationBloc.add(LoggedOut());
        print(error);
        yield ProfileFailure(error: error.toString());
      }
    }
  }
}
