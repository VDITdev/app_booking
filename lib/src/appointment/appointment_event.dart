part of 'appointment_bloc.dart';

abstract class AppointmentEvent {}

class NameAppointmentEvent extends AppointmentEvent {
  final String name;
  NameAppointmentEvent({required this.name});
}

class EmailAppointmentEvent extends AppointmentEvent {
  final String email;
  EmailAppointmentEvent({required this.email});
}

class DateAppointmentEvent extends AppointmentEvent {
  final String date;
  DateAppointmentEvent({required this.date});
}

class TimeAppointmentEvent extends AppointmentEvent {
  final String time;
  TimeAppointmentEvent({required this.time});
}

class AddAppointmentEvent extends AppointmentEvent {
  
}
