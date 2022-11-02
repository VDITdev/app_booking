import 'package:app_booking/utils/state/status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentState());

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {

    if(event is NameAppointmentEvent){
      yield state.copyWith(name: event.name);
    }
    if(event is EmailAppointmentEvent){
      yield state.copyWith(email: event.email);
    }
    if(event is DateAppointmentEvent){
      yield state.copyWith(date: event.date);
    }
    if(event is TimeAppointmentEvent){
      yield state.copyWith(time: event.time);
    }
    if(event is AddAppointmentEvent){
      try {
        yield state.copyWith(status: StatusSucess());
      } catch (e) {
        yield state.copyWith(status: StatusFailed(e: e));
      }
    }

  }
}
