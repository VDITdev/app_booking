import 'package:app_booking/src/appointment/appointment_bloc.dart';
import 'package:app_booking/utils/state/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    _timeController.text = ""; //set the initial value of text field
    _nameController.text = ""; //set the initial value of text field
    _emailController.text = ""; //set the initial value of text field

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBloc(),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          leading: CupertinoNavigationBarBackButton(previousPageTitle: 'Back'),
          middle: Text('Appointment'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(Icons.circle_sharp, color: Colors.grey),
            onPressed: () {},
          ),
        ),

        // Bloc for whole page
        child: BlocConsumer<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            // print(state.name);
            setState(() {
              _nameController.text = state.name;
              _emailController.text = state.email;

              // Catch Date from Event
              String dateFormatted =
                  DateFormat('dd / MM / yyyy').format(state.date);
              _dateController.text = dateFormatted;

              // Catch Time from Event
              DateTime parsedTime =
                  DateFormat.jm().parse(state.time.format(context).toString());
              String timeFormatted = DateFormat('HH : mm').format(parsedTime);
              _timeController.text = timeFormatted;
            });
          },
          builder: (Acontext, state) {
            return SafeArea(
              bottom: false,
              child: SfCalendar(
                view: CalendarView.timelineDay,
                showNavigationArrow: true,
                showDatePickerButton: true,
                // controller: _controller,
                allowDragAndDrop: true,
                onDragEnd: dragEnd,
                allowAppointmentResize: true,
                onAppointmentResizeEnd: resizeEnd,
                // onSelectionChanged: selectionChanged,
                dataSource: AppointmentDataSource(
                  _resourceColl(),
                  _appointmentDataSource(),
                  
                ),
                headerDateFormat: 'dd / MM / yyyy',
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // loadMoreWidgetBuilder: _loadAppointment(),
                timeSlotViewSettings: const TimeSlotViewSettings(
                  // startHour: 9,
                  // endHour: 19,
                  timeInterval:
                      (kIsWeb) ? Duration(minutes: 15) : Duration(minutes: 60),
                  timeFormat: 'HH:mm',
                  timeTextStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  timelineAppointmentHeight: 100,
                  timeIntervalWidth: 90,
                ),
                resourceViewSettings: const ResourceViewSettings(
                  showAvatar: false,
                  displayNameTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                appointmentBuilder: (context, details) {

                  // test


                  // print(_controller.);



                  //

                  final Appointment appointment = details.appointments.first;
                  if (_controller.view != CalendarView.timelineDay) {
                    return Scaffold(
                      body: Container(
                        height: details.bounds.height,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: appointment.color),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                appointment.notes!,
                                // meeting.subject,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
                
                onTap: (value) {
                  if (value.targetElement != CalendarElement.header &&
                      value.targetElement != CalendarElement.viewHeader &&
                      value.targetElement != CalendarElement.resourceHeader) {
                    Acontext.read<AppointmentBloc>()
                        .add(DateAppointmentEvent(date: value.date!));
                    Acontext.read<AppointmentBloc>().add(TimeAppointmentEvent(
                        time: TimeOfDay.fromDateTime(value.date!)));

                    if (value.targetElement == CalendarElement.appointment) {
                      final Appointment appointment = value.appointments?.first;
                      Acontext.read<AppointmentBloc>()
                          .add(NameAppointmentEvent(name: appointment.notes!));
                      Acontext.read<AppointmentBloc>().add(
                          EmailAppointmentEvent(
                              email: appointment.resourceIds![1].toString()));
                    } else {
                      Acontext.read<AppointmentBloc>()
                          .add(InitAppointmentEvent());
                    }
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _fromBuilder();
                      },
                    );
                  } else {}
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _fromBuilder() {
    return BlocProvider(
      // add Init
      create: (context) => AppointmentBloc(),
      child: Form(
        key: _formKey,
        child: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _nameAppointment(),
              _emailAppointment(),
              _dateAppointment(),
              _timeAppointment(),
              _addAppointment(),
            ],
          ),
        ),
      ),
    );
    ;
  }

  Widget _nameAppointment() {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // print(state.name);
        setState(() {
          _nameController.text = state.name;
        });
      },
      builder: (context, state) {
        return CupertinoTextFormFieldRow(
          placeholder: 'Enter Name',
          keyboardType: TextInputType.text,
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          enableSuggestions: true,
          validator: (checkValue) {
            context
                .read<AppointmentBloc>()
                .add(NameAppointmentEvent(name: checkValue!));
          },
          onFieldSubmitted: (updateValue) {
            context
                .read<AppointmentBloc>()
                .add(NameAppointmentEvent(name: updateValue));
          },
        );
      },
    );
  }

  Widget _emailAppointment() {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // print(state.email);
        setState(() {
          _emailController.text = state.email;
        });
      },
      builder: (context, state) {
        return CupertinoTextFormFieldRow(
          placeholder: 'Enter Email',
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          autocorrect: false,
          validator: (checkValue) {
            context
                .read<AppointmentBloc>()
                .add(EmailAppointmentEvent(email: checkValue!));
          },
          onFieldSubmitted: (updateValue) {
            context
                .read<AppointmentBloc>()
                .add(EmailAppointmentEvent(email: updateValue));
          },
          // controller: ,
        );
      },
    );
  }

  Widget _dateAppointment() {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // print(state.status);
        // print(state.date);
        setState(() {
          String dateFormatted =
              DateFormat('dd / MM / yyyy').format(state.date);
          _dateController.text = dateFormatted;
        });
      },
      builder: (context, state) {
        return CupertinoTextFormFieldRow(
          placeholder: 'Enter Date',
          controller: _dateController,
          readOnly: true,
          onTap: () {
            context
                .read<AppointmentBloc>()
                .add(DayPickerAppointmentEvent(context));
          },
        );
      },
    );
  }

  Widget _timeAppointment() {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // print(state.status);
        // print(state.time);
        setState(() {
          DateTime parsedTime =
              DateFormat.jm().parse(state.time.format(context).toString());
          String timeFormatted = DateFormat('HH : mm').format(parsedTime);
          _timeController.text = timeFormatted;
        });
      },
      builder: (context, state) {
        return CupertinoTextFormFieldRow(
            placeholder: 'Enter Time',
            controller: _timeController,
            readOnly: true,
            onTap: () {
              context
                  .read<AppointmentBloc>()
                  .add(TimePickerAppointmentEvent(context));
            });
      },
    );
  }

  Widget _addAppointment() {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        // print(state.status);
      },
      builder: (context, state) {
        return CupertinoButton.filled(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AppointmentBloc>().add(AddAppointmentEvent());
            }
            // Navigator.pop(context);
          },
        );
      },
    );
  }

  // Widget _loadAppointment() {
  //   return BlocConsumer<AppointmentBloc, AppointmentState>(
  //     listener: (context, state) {
  //       // TODO: implement listener
  //     },
  //     builder: (context, state) {
  //       return Container(
  //           alignment: Alignment.center, child: const CircularProgressIndicator());
  //     },
  //   );
  // }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
    dynamic appointment = appointmentDragEndDetails.appointment!;
    CalendarResource? sourceResource = appointmentDragEndDetails.sourceResource;
    CalendarResource? targetResource = appointmentDragEndDetails.targetResource;
    DateTime? droppingTime = appointmentDragEndDetails.droppingTime;
  }

  void resizeEnd(AppointmentResizeEndDetails appointmentResizeEndDetails) {
    dynamic appointment = appointmentResizeEndDetails.appointment;
    DateTime? startTime = appointmentResizeEndDetails.startTime;
    DateTime? endTime = appointmentResizeEndDetails.endTime;
    CalendarResource? resourceDetails = appointmentResizeEndDetails.resource;
  }

  void selectionChanged(CalendarSelectionDetails details) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              child: new Text("Details shown by selection changed callback")),
          content:
              Container(child: new Text("You have selected " + '${_dateController.text}')),
          actions: <Widget>[
            new TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text('close'))
          ],
        );
      });
}

  List<CalendarResource> _resourceColl() {
    List<CalendarResource> resourceColl = <CalendarResource>[];
    resourceColl.addAll(
      [
        CalendarResource(
          displayName: 'John',
          id: '0001',
          color: Colors.redAccent,
        ),
        CalendarResource(
          displayName: 'Mark',
          id: '0002',
          color: Colors.tealAccent,
        ),
        CalendarResource(
          displayName: 'Selina',
          id: '0003',
          color: Colors.lightBlueAccent,
        ),
        CalendarResource(
          displayName: 'Tune',
          id: '0004',
          color: Colors.lightGreenAccent,
        ),
        CalendarResource(
          displayName: 'Staff 1',
          id: '0005',
          color: Colors.amberAccent,
        ),
        CalendarResource(
          displayName: 'Staff 2',
          id: '0006',
          color: Colors.indigoAccent,
        ),
      ],
    );
    return resourceColl;
  }

  List<Appointment> _appointmentDataSource() {
    List<Appointment> appointments = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, today.hour);
    final DateTime endTime = startTime.add(const Duration(hours: 1));

    appointments.addAll(
      [
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Nails',
          notes: 'NAME 1',
          color: Colors.orange,
          resourceIds: ['0001', '111@111.com'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Spa',
          notes: 'NAME 2',
          color: Colors.pinkAccent,
          resourceIds: ['0002', '222@222.com'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Beauty',
          notes: 'NAME 3',
          color: Colors.blueGrey,
          resourceIds: ['0003', '333@333.com'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Massage',
          notes: 'NAME 4',
          color: Colors.deepPurpleAccent,
          resourceIds: ['0004', '444@444.com'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Haircut',
          notes: 'NAME 5',
          color: Colors.lightGreen,
          resourceIds: ['0005', '555@555.com'],
        )
      ],
    );
    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(
    List<CalendarResource> resourceColl,
      List<Appointment> source, ) {
    appointments = source;
    resources = resourceColl;
  }

  // ??? https://www.syncfusion.com/kb/11204/how-to-design-and-configure-your-appointment-editor-in-flutter-calendar
  // @override
  // List<Object> getResourceIds(int index) {
  //   return appointments![index].ids;
  // }
  // @override
  // String getLocation(int index) {
  //   return appointments![index].place;
  // }
}
