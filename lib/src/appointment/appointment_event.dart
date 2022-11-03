part of 'appointment_bloc.dart';

abstract class AppointmentEvent {}

class InitAppointmentEvent extends AppointmentEvent {}

class NameAppointmentEvent extends AppointmentEvent {
  final String name;
  NameAppointmentEvent({required this.name});
}

class EmailAppointmentEvent extends AppointmentEvent {
  final String email;
  EmailAppointmentEvent({required this.email});
}

class DateAppointmentEvent extends AppointmentEvent {
  final DateTime date;
  DateAppointmentEvent({required this.date});
}

class DayPickerAppointmentEvent extends AppointmentEvent {
  final BuildContext context;
  DayPickerAppointmentEvent(this.context);
}

class TimeAppointmentEvent extends AppointmentEvent {
  final TimeOfDay time;
  TimeAppointmentEvent({required this.time});
}

class TimePickerAppointmentEvent extends AppointmentEvent {
  final BuildContext context;
  TimePickerAppointmentEvent(this.context);
}

class AddAppointmentEvent extends AppointmentEvent {}
