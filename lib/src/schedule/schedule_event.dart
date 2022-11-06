part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class InitScheduleEvent extends ScheduleEvent {}

class NameScheduleEvent extends ScheduleEvent {
  final String name;
  NameScheduleEvent({required this.name});
}

class EmailScheduleEvent extends ScheduleEvent {
  final String email;
  EmailScheduleEvent({required this.email});
}

class DateScheduleEvent extends ScheduleEvent {
  final DateTime date;
  DateScheduleEvent({required this.date});
}

class DayPickerScheduleEvent extends ScheduleEvent {
  final BuildContext context;
  DayPickerScheduleEvent(this.context);
}

class TimeScheduleEvent extends ScheduleEvent {
  final TimeOfDay time;
  TimeScheduleEvent({required this.time});
}

class TimePickerScheduleEvent extends ScheduleEvent {
  final BuildContext context;
  TimePickerScheduleEvent(this.context);
}

class LoadMoreAppointment extends ScheduleEvent {}

class AddScheduleEvent extends ScheduleEvent {}
