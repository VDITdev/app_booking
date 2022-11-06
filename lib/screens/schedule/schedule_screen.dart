import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:app_booking/src/schedule/schedule_bloc.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    _timeController.text = ""; //set the initial value of text field
    _nameController.text = ""; //set the initial value of text field
    // _emailController.text = ""; //set the initial value of text field

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          leading: CupertinoNavigationBarBackButton(previousPageTitle: 'Back'),
          middle: Text('Schedule'),
          trailing: PopupMenuButton(
            position: PopupMenuPosition.under,
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.blue,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('By Day'),
                  onTap: (() {
                    _controller.view = CalendarView.timelineDay;
                  }),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('By Month'),
                  onTap: (() {
                    _controller.view = CalendarView.timelineMonth;
                  }),
                ),
              ];
            },
          ),
        ),
        // Bloc for whole page
        body: BlocConsumer<ScheduleBloc, ScheduleState>(
          listener: (context, state) {
            // print(state.name);
            setState(() {
              _nameController.text = state.name;
              // _emailController.text = state.email;

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
                view: CalendarView.timelineMonth,
                controller: _controller,
                showNavigationArrow: true,
                showDatePickerButton: true,
                allowDragAndDrop: true,
                // onDragEnd: dragEnd,
                // allowAppointmentResize: true,
                // onAppointmentResizeEnd: resizeEnd,
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
                // specialRegions: _getTimeRegions(),
                // timeRegionBuilder: timeRegionBuilder,
                // loadMoreWidgetBuilder: _loadAppointment(),
                timeSlotViewSettings: const TimeSlotViewSettings(
                  // startHour: 9,
                  // endHour: 19,
                  // timeInterval:
                  //     (kIsWeb) ? Duration(minutes: 15) : Duration(minutes: 60),
                  // timeFormat: 'HH:mm',
                  // timeTextStyle: TextStyle(
                  //   fontSize: 12,
                  //   color: Colors.black,
                  // ),
                  timelineAppointmentHeight: 100,
                  timeIntervalWidth: 80,
                  // numberOfDaysInView: 7,
                ),
                resourceViewSettings: const ResourceViewSettings(
                  showAvatar: false,
                  displayNameTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                // monthViewSettings: MonthViewSettings(showAgenda: true),
                appointmentBuilder: (context, details) {
                  final Appointment appointment = details.appointments.first;
                  // if (_controller.view != CalendarView.timelineDay) {
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
                  // }
                  return Container();
                },

                onTap: (value) {
                  if (value.targetElement != CalendarElement.header &&
                      value.targetElement != CalendarElement.viewHeader &&
                      value.targetElement != CalendarElement.resourceHeader) {
                    Acontext.read<ScheduleBloc>()
                        .add(DateScheduleEvent(date: value.date!));
                    Acontext.read<ScheduleBloc>().add(TimeScheduleEvent(
                        time: TimeOfDay.fromDateTime(value.date!)));

                    if (value.targetElement == CalendarElement.appointment) {
                      final Appointment appointment = value.appointments?.first;
                      Acontext.read<ScheduleBloc>()
                          .add(NameScheduleEvent(name: appointment.notes!));
                      // Acontext.read<ScheduleBloc>().add(EmailScheduleEvent(
                      //     email: appointment.resourceIds![1].toString()));
                    } else {
                      Acontext.read<ScheduleBloc>().add(InitScheduleEvent());
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
      create: (context) => ScheduleBloc(),
      child: Form(
        key: _formKey,
        child: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _nameAppointment(),
              // _emailAppointment(),
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
    return BlocConsumer<ScheduleBloc, ScheduleState>(
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
                .read<ScheduleBloc>()
                .add(NameScheduleEvent(name: checkValue!));
          },
          onFieldSubmitted: (updateValue) {
            context
                .read<ScheduleBloc>()
                .add(NameScheduleEvent(name: updateValue));
          },
        );
      },
    );
  }

  // Widget _emailAppointment() {
  //   return BlocConsumer<ScheduleBloc, ScheduleState>(
  //     listener: (context, state) {
  //       // print(state.email);
  //       setState(() {
  //         _emailController.text = state.email;
  //       });
  //     },
  //     builder: (context, state) {
  //       return CupertinoTextFormFieldRow(
  //         placeholder: 'Enter Email',
  //         keyboardType: TextInputType.emailAddress,
  //         controller: _emailController,
  //         autocorrect: false,
  //         validator: (checkValue) {
  //           context
  //               .read<ScheduleBloc>()
  //               .add(EmailScheduleEvent(email: checkValue!));
  //         },
  //         onFieldSubmitted: (updateValue) {
  //           context
  //               .read<ScheduleBloc>()
  //               .add(EmailScheduleEvent(email: updateValue));
  //         },
  //         // controller: ,
  //       );
  //     },
  //   );
  // }

  Widget _dateAppointment() {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
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
            context.read<ScheduleBloc>().add(DayPickerScheduleEvent(context));
          },
        );
      },
    );
  }

  Widget _timeAppointment() {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
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
                  .read<ScheduleBloc>()
                  .add(TimePickerScheduleEvent(context));
            });
      },
    );
  }

  Widget _addAppointment() {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        // print(state.status);
      },
      builder: (context, state) {
        return CupertinoButton.filled(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ScheduleBloc>().add(AddScheduleEvent());
            }
            // Navigator.pop(context);
          },
        );
      },
    );
  }

  // Widget timeRegionBuilder(
  //     BuildContext context, TimeRegionDetails timeRegionDetails) {
  //   if (timeRegionDetails.region.text == "Lunch") {
  //     return Container(
  //       color: timeRegionDetails.region.color,
  //       alignment: Alignment.center,
  //       child: Icon(
  //         Icons.restaurant,
  //         color: Colors.grey.withOpacity(0.5),
  //       ),
  //     );
  //   } else if (timeRegionDetails.region.text == "WeekEnd") {
  //     return Container(
  //       color: timeRegionDetails.region.color,
  //       alignment: Alignment.center,
  //       child: Icon(
  //         Icons.weekend,
  //         color: Colors.grey.withOpacity(0.5),
  //       ),
  //     );
  //   } else {
  //     return CircularProgressIndicator();
  //   }
  // }

  // List<TimeRegion> _getTimeRegions() {
  //   final List<TimeRegion> regions = <TimeRegion>[];
  //   DateTime date = DateTime.now();
  //   regions.add(TimeRegion(
  //     startTime: DateTime.now(),
  //     endTime: DateTime.now().add(Duration(days: 14)),
  //     enablePointerInteraction: true,
  //     color: Colors.grey.withOpacity(0.2),
  //     recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
  //     text: 'Lunch',
  //   ));
  //   regions.add(TimeRegion(
  //     startTime: DateTime.now(),
  //     endTime: DateTime.now().add(Duration(days: 14)),
  //     recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT,SUN',
  //     color: Color(0xffbD3D3D3),
  //     text: 'WeekEnd',
  //   ));
  //   return regions;
  // }

  // Widget _loadAppointment() {
  //   return BlocConsumer<ScheduleBloc, ScheduleState>(
  //     listener: (context, state) {
  //       // TODO: implement listener
  //     },
  //     builder: (context, state) {
  //       return Container(
  //           alignment: Alignment.center, child: const CircularProgressIndicator());
  //     },
  //   );
  // }

  // void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {
  //   dynamic appointment = appointmentDragEndDetails.appointment!;
  //   CalendarResource? sourceResource = appointmentDragEndDetails.sourceResource;
  //   CalendarResource? targetResource = appointmentDragEndDetails.targetResource;
  //   DateTime? droppingTime = appointmentDragEndDetails.droppingTime;
  // }

  // void resizeEnd(AppointmentResizeEndDetails appointmentResizeEndDetails) {
  //   dynamic appointment = appointmentResizeEndDetails.appointment;
  //   DateTime? startTime = appointmentResizeEndDetails.startTime;
  //   DateTime? endTime = appointmentResizeEndDetails.endTime;
  //   CalendarResource? resourceDetails = appointmentResizeEndDetails.resource;
  // }

  // void selectionChanged(CalendarSelectionDetails details) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Container(
  //               child: new Text("Details shown by selection changed callback")),
  //           content: Container(
  //               child:
  //                   new Text("You have selected " + '${_dateController.text}')),
  //           actions: <Widget>[
  //             new TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: new Text('close'))
  //           ],
  //         );
  //       });
  // }

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
          color: Colors.orange,
        ),
        CalendarResource(
          displayName: 'Selina',
          id: '0003',
          color: Colors.lightGreen,
        ),
        CalendarResource(
          displayName: 'Tune',
          id: '0004',
          color: Colors.tealAccent,
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
    // DateTime exceptionDate = DateTime(2022, 11, 11);
    appointments.addAll(
      [
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Nails',
          notes: 'NAME 1',
          color: Colors.lightBlueAccent,
          resourceIds: ['0001'],
          // recurrenceRule: 'FREQ=DAILY;INTERVAL=1;COUNT=10',
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Spa',
          notes: 'NAME 2',
          color: Colors.lightBlueAccent,
          resourceIds: ['0002'],
          // recurrenceRule: 'FREQ=DAILY;COUNT=20',
          // recurrenceExceptionDates: <DateTime>[exceptionDate]
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Beauty',
          notes: 'NAME 3',
          color: Colors.lightBlueAccent,
          resourceIds: ['0003'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Massage',
          notes: 'NAME 4',
          color: Colors.lightBlueAccent,
          resourceIds: ['0004'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Haircut',
          notes: 'NAME 5',
          color: Colors.lightBlueAccent,
          resourceIds: ['0005'],
        )
      ],
    );
    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(
    List<CalendarResource> resourceColl,
    List<Appointment> source,
  ) {
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
