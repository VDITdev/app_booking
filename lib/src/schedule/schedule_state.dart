part of 'schedule_bloc.dart';

class ScheduleState {
  final String name;
  final String email;
  final DateTime date;
  final TimeOfDay time;
  final Status status;

  ScheduleState({
    this.name = '',
    this.email = '',
    required this.date,
    required this.time,
    this.status = const StatusInitial(),
  });

  ScheduleState copyWith({
    String? name,
    String? email,
    DateTime? date,
    TimeOfDay? time,
    Status? status,
  }) {
    return ScheduleState(
      name: name ?? this.name,
      email: email ?? this.email,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'ScheduleState(name: $name, email: $email, date: $date, time: $time, status: $status)';
  }
}
