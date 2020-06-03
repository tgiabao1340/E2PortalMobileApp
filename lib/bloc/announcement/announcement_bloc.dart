
import 'package:bloc/bloc.dart';
import 'package:e2portal/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//State
abstract class AnnouncementState extends Equatable{

  const AnnouncementState();

  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends  AnnouncementState{}

class AnnouncementLoading extends  AnnouncementState{}

class AnnouncementFailure extends  AnnouncementState{
  final String error;

  const AnnouncementFailure({@required this.error});

}

//Event
abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();
}
class AnnouncementRequest extends AnnouncementEvent{
  final List<Announcement> listAnnouncement;

  AnnouncementRequest({@required this.listAnnouncement});

  @override
  List<Object> get props => [listAnnouncement];

}
//Bloc process
class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState>{

  @override
  AnnouncementState get initialState => AnnouncementInitial();

  @override
  Stream<AnnouncementState> mapEventToState(AnnouncementEvent event) async* {
    if(event is AnnouncementRequest){
      yield AnnouncementLoading();
      try{

        yield AnnouncementInitial();
      }catch(error){
        yield AnnouncementFailure(error: error.toString());
      }
    }
  }

}