import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {

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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Appointment'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      child: SafeArea(
        child: SfCalendar(
          view: CalendarView.timelineDay,
          todayHighlightColor: Colors.black,
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
            timeInterval: (kIsWeb) ? Duration(minutes: 15) : Duration(minutes: 60),
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
      
          headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.center),
          
          onTap: (CalendarTapDetails details) {
            // dynamic appointment = details.appointments;
            // DateTime date = details.date!;
            // CalendarElement element = details.targetElement;
            // print(details.targetElement == CalendarElement.resourceHeader);
      
            if(details.targetElement != CalendarElement.header){
      
              String dateFormatted = DateFormat('dd / MM / yyyy').format(details.date!);
              String timeFormatted = DateFormat('HH : mm').format(details.date!);
      
              setState(() {
                dateController.text = dateFormatted;
                timeController.text = timeFormatted;
              });
      
              if (details.targetElement == CalendarElement.calendarCell) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    // scrollable: true,
                    title: Text('Add New'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            CupertinoTextFormFieldRow(
                              placeholder: 'Enter text',
                            ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Name',
                            //     icon: Icon(Icons.account_box),
                            //   ),
                            // ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Email',
                            //     icon: Icon(Icons.email),
                            //   ),
                            // ),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Message',
                            //     icon: Icon(Icons.message),
                            //   ),
                            // ),
                            // TextField(
                                
                            //       controller: dateController, //editing controller of this TextField
                            //       decoration: const InputDecoration( 
                                  
                            //         icon: Icon(Icons.calendar_month), //icon of text field
                            //         labelText: "Booking Date" //label text of field
                            //       ),
                            //       readOnly: true,  // when true user cannot edit text 
                            //       onTap: () async {
                            //         DateTime? pickedDate = await showDatePicker(
                            //             context: context,
                            //             initialDate: details.date!, //get today's date
                            //             firstDate: DateTime(2015), //DateTime.now() - not to allow to choose before today.
                            //             lastDate: DateTime(2030)
                            //         );
                                    
                            //         if(pickedDate != null ){
                            //             print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                            //              DateFormat('dd / MM / yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            //             print(dateFormatted); //formatted date output using intl package =>  2022-07-04
                            //               //You can format date as per your need
      
                            //             setState(() {
                            //               dateFormatted = dateFormatted;
                            //               dateController.text = dateFormatted; //set foratted date to TextField value. 
                            //             });
                            //         }else{
                            //             print("Date is not selected");
                            //         }
                            //       },
                            //   ),
      
                            //   TextField(
                            //     controller: timeController, //editing controller of this TextField
                            //     decoration: InputDecoration( 
                            //       icon: Icon(Icons.timer), //icon of text field
                            //       labelText: "Booking Time" //label text of field
                            //     ),
                            //     readOnly: true,
                            //     onTap: () async {
                            //       TimeOfDay? pickedTime =  await showTimePicker(
                            //               initialTime: TimeOfDay.fromDateTime(details.date!),
                            //               context: context,
                            //           );
                            //       if(pickedTime != null ){
                            //           print(pickedTime.format(context));
                            //           DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            //           String formattedTime = DateFormat('HH : mm').format(parsedTime);
                            //           print(formattedTime);
                            //           setState(() {
                            //             timeController.text = formattedTime;
                            //           });
                            //         }else{
                            //             print("Time is not selected");
                            //         }
                            //       },
                            //   )
                            
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      CupertinoButton.filled(
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
            }
      
            
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
