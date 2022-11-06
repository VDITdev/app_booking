import 'package:app_booking/utils/state/status.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(ScheduleState(date: DateTime.now(), time: TimeOfDay.now()));

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (event is InitScheduleEvent) {
      yield state.copyWith(name: '', email: '');
    }
    if (event is NameScheduleEvent) {
      yield state.copyWith(name: event.name);
    }
    if (event is EmailScheduleEvent) {
      yield state.copyWith(email: event.email);
    }
    if (event is DateScheduleEvent) {
      yield state.copyWith(date: event.date);
    }
    if (event is DayPickerScheduleEvent) {
      try {
        DateTime? pickedDate = await showDatePicker(
            context: event.context,
            initialDate: state.date,
            firstDate: DateTime(2015),
            lastDate: DateTime(2030));
        if (pickedDate != null) {
          yield state.copyWith(status: StatusSucess());
          yield state.copyWith(date: pickedDate);
        }
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }
    if (event is TimeScheduleEvent) {
      yield state.copyWith(time: event.time);
    }
    if (event is TimePickerScheduleEvent) {
      try {
        TimeOfDay? pickedTime = await showTimePicker(
          context: event.context,
          initialTime: TimeOfDay.fromDateTime(state.date),
        );
        if (pickedTime != null) {
          yield state.copyWith(status: StatusSucess());
          yield state.copyWith(time: pickedTime);
        }
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }

    if (event is AddScheduleEvent) {
      try {
        print(state.toString());
        yield state.copyWith(status: StatusSucess());
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }
  }
}
