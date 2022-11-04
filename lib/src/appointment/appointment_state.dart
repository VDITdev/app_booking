part of 'appointment_bloc.dart';

class AppointmentState {
  final String name;
  final String email;
  final DateTime date;
  final TimeOfDay time;
  final Status status;

  AppointmentState({
    this.name = '',
    this.email = '',
    required this.date,
    required this.time,
    this.status = const StatusInitial(),
  });

  AppointmentState copyWith({
    String? name,
    String? email,
    DateTime? date,
    TimeOfDay? time,
    Status? status,
  }) {
    return AppointmentState(
      name: name ?? this.name,
      email: email ?? this.email,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'AppointmentState(name: $name, email: $email, date: $date, time: $time, status: $status)';
  }
}
