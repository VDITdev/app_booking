import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SfCalendar(
        view: CalendarView.timelineDay,
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
          startHour: 9,
          endHour: 19,
          timeInterval: Duration(minutes: 30),
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
        onTap: (CalendarTapDetails details) {
          // dynamic appointment = details.appointments;
          // DateTime date = details.date!;
          // CalendarElement element = details.targetElement;

          if (details.targetElement.index == 2) {
            // Open Popup Add New when index = 2
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Add New'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: Icon(Icons.account_box),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Message',
                              icon: Icon(Icons.message),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          // your code
                        })
                  ],
                );
              },
            );
          } else {
            // Open Popup Review/Amend when index = 3
          }
        },
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
