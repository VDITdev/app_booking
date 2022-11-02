import 'package:app_booking/utils/state/status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentState(date: DateTime.now(), time: TimeOfDay.now()));

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {

    // if(event is InitAppointmentEvent){
    //   yield state;
    // }
    if(event is NameAppointmentEvent){
      yield state.copyWith(name: event.name);
    }
    if(event is EmailAppointmentEvent){
      yield state.copyWith(email: event.email);
    }
    if(event is DateAppointmentEvent){
      yield state.copyWith(date: event.date);
    }
    if(event is OpenPickerAppointmentEvent){
      DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: state.date,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

      if (pickedDate!=null){
        yield state.copyWith(status: StatusSucess());
        yield state.copyWith(date: pickedDate);
        
      }
    }

    if(event is TimeAppointmentEvent){
      yield state.copyWith(time: event.time);
    }


    if(event is AddAppointmentEvent){
      try {
        print('TEST: ' + state.name + state.email + state.date.toString() + state.time.toString());
        yield state.copyWith(status: StatusSucess());
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }

  }
}
