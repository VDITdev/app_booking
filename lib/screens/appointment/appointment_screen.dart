import 'package:app_booking/src/appointment/appointment_bloc.dart';
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

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    timeController.text = ""; //set the initial value of text field
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.add),
        // ),
        child: BlocConsumer<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            // print(state.name);
            // print(state.email);
          },
          builder: (Acontext, state) {
            return SafeArea(
              bottom: false,
              child: SfCalendar(
                view: CalendarView.timelineDay,
                todayHighlightColor: Colors.blue,
                showNavigationArrow: true,
                showDatePickerButton: true,
                allowDragAndDrop: true,
                onDragEnd: dragEnd,
                allowAppointmentResize: true,
                onAppointmentResizeEnd: resizeEnd,
                dataSource: AppointmentDataSource(
                  _appointmentDataSource(),
                  _resourceColl(),
                ),
                timeSlotViewSettings: TimeSlotViewSettings(
                  // startHour: 9,
                  // endHour: 19,
                  timeInterval:
                      (kIsWeb) ? Duration(minutes: 15) : Duration(minutes: 60),
                  timeFormat: 'HH:mm',
                  timeTextStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                resourceViewSettings: ResourceViewSettings(
                  showAvatar: false,
                  displayNameTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
                onTap: (CalendarTapDetails details) {
                  // dynamic appointment = details.appointments;
                  // DateTime date = details.date!;
                  // CalendarElement element = details.targetElement;
                  // print(details.targetElement == CalendarElement.resourceHeader);

                  if (details.targetElement != CalendarElement.header) {
                    String dateFormatted =
                        DateFormat('dd / MM / yyyy').format(details.date!);
                    String timeFormatted =
                        DateFormat('HH : mm').format(details.date!);

                    setState(() {
                      dateController.text = dateFormatted;
                      timeController.text = timeFormatted;
                    });

                    if (details.targetElement == CalendarElement.calendarCell) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Form(
                            key: _formKey,
                            child: Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                _nameAppointment(Acontext),
                                _emailAppointment(Acontext),
                                CupertinoTextFormFieldRow(
                                  placeholder: 'Enter Date',
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () {
                                    _showDatePicker(dateFormatted, details);
                                  },
                                ),
                                CupertinoTextFormFieldRow(
                                  placeholder: 'Enter Time',
                                  controller: timeController,
                                  readOnly: true,
                                  onTap: () {
                                    _showTimePicker(timeFormatted, details);
                                  },
                                ),
                                _addAppointment(Acontext),
                                SizedBox(height: 60)
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      // Open Popup Review/Amend when index = 3
                    }
                  } else {}
                },
              ),
            );
          },
        ),
      ),
    );
  }

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

  void _showDatePicker(String dateFormatted, CalendarTapDetails details) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: details.date!,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

    if (pickedDate != null) {
      // print(pickedDate);
      dateFormatted = DateFormat('dd / MM / yyyy').format(pickedDate);
      // print(dateFormatted);
      setState(() {
        dateController.text = dateFormatted;
      });
    }
  }

  void _showTimePicker(String timeFormatted, CalendarTapDetails details) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(details.date!),
      context: context,
    );
    if (pickedTime != null) {
      // print(pickedTime.format(context));
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());
      timeFormatted = DateFormat('HH : mm').format(parsedTime);
      // print(formattedTime);
      setState(() {
        timeController.text = timeFormatted;
      });
    } else {
      print("Time is not selected");
    }
  }

  Widget _nameAppointment(BuildContext Acontext) {
    return CupertinoTextFormFieldRow(
      placeholder: 'Enter Name',
      keyboardType: TextInputType.name,
      validator: (value) {},
      onChanged: (value) {
        Acontext.read<AppointmentBloc>().add(NameAppointmentEvent(name: value));
      },
      // controller: ,
    );
  }

  Widget _emailAppointment(BuildContext Acontext) {
    return CupertinoTextFormFieldRow(
      placeholder: 'Enter Email',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {},
      onChanged: (value) {
        Acontext.read<AppointmentBloc>().add(EmailAppointmentEvent(email: value));
      },
      // controller: ,
    );
  }

  Widget _addAppointment(BuildContext Acontext) {
    return CupertinoButton.filled(
      child: Text('Add'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Acontext.read<AppointmentBloc>().add(AddAppointmentEvent());
        }
        // Navigator.pop(context);
      },
    );
  }

  List<CalendarResource> _resourceColl() {
    List<CalendarResource> resourceColl = <CalendarResource>[];
    resourceColl.addAll(
      [
        CalendarResource(
          displayName: 'John',
          id: '0000',
          color: Colors.redAccent,
        ),
        CalendarResource(
          displayName: 'Mark',
          id: '0001',
          color: Colors.tealAccent,
        ),
        CalendarResource(
          displayName: 'Selina',
          id: '0002',
          color: Colors.lightBlueAccent,
        ),
        CalendarResource(
          displayName: 'Tune',
          id: '0003',
          color: Colors.lightGreenAccent,
        ),
        CalendarResource(
          displayName: 'Staff 1',
          id: '0004',
          color: Colors.amberAccent,
        ),
        CalendarResource(
          displayName: 'Staff 2',
          id: '0005',
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
          color: Colors.orange,
          resourceIds: ['0000'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Spa',
          color: Colors.pinkAccent,
          resourceIds: ['0001'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Beauty',
          color: Colors.blueGrey,
          resourceIds: ['0002'],
        ),
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: 'Massage',
          color: Colors.deepPurpleAccent,
          resourceIds: ['0003'],
        )
      ],
    );
    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(
      List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }

  @override
  List<Object> getResourceIds(int index) {
    return appointments![index].ids;
  }
}
