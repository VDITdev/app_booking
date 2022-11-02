part of 'appointment_bloc.dart';


class AppointmentState {


  final String name;
  final String email;
  final String date;
  final String time;
  final Status status;


  AppointmentState({
    this.name = '',this.email = '', this.date = '', this.time = '', this.status = const StatusInitial()
  });

  AppointmentState copyWith({
    String? name,
    String? email,
    String? date,
    String? time,
    Status? status,
  }) {
    return AppointmentState(
      name: name ?? this.time,
      email: email ?? this.email,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

}

class AppointmentInitial extends AppointmentState {}
