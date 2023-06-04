// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/controllers/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String name;
  final ProfileInfo profileInfo;
  final String specialty;
  final String imageUrl;
  final String education;
  final String experience;
  final String awards;

  const DoctorDetailsPage({
    Key? key,
    required this.name,
    required this.profileInfo,
    required this.specialty,
    required this.imageUrl,
    required this.education,
    required this.experience,
    required this.awards,
  }) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  late DateTime _selectedTime;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _selectedTime = DateTime.now();
  }

  void _handleTimeSelected(DateTime time) {
    setState(() {
      _selectedTime = time;
    });
    print(_selectedTime);
  }

  void _showDialogWithAnimation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text("Appointment Request Sent"),
            SizedBox(width: 5),
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00846c),
              size: 30,
            ),
          ],
        ),
        content: Text("Your appointment request has been sent successfully."),
        actions: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text("Thank you"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _addAppointment() async {
    if (_selectedTime != "") {
      setState(() {
        _isLoading = true;
      });
      // setState(() {
      //   _errorMessage = '';
      // });
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? userId = prefs.getString('user_id');
        final String? firstName = prefs.getString('firstName');
        final String? lastName = prefs.getString('lastName');
        final String? birthday = prefs.getString('birthday');
        final String? sexe = prefs.getString('sexe');
        final String? phone = prefs.getString('phone');

        final data = await addAppointmentAPI({
          "patientId": userId,
          "firstName": firstName,
          "lastName": lastName,
          "birthday": birthday,
          "createdAt": DateTime.now().toString(),
          "initialType": "P",
          "appointmentDate": _selectedTime.toString(),
          "description": "",
          "phone": phone,
          "type": "P",
          "sexe": sexe
        });

        // Show success dialog
        _showDialogWithAnimation();
        // Use the returned data to authenticate the user
        // ...
      } catch (e) {
        setState(() {
          print(e); //<-------------
          // _errorMessage = 'Failed to login. Please try again.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Book Appointment"),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Profile(profileInfo: widget.profileInfo),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Select Date and Time : ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  WorkHours(
                      workHours: "6:00 AM - 7:00 PM",
                      onDateTimeSelected: _handleTimeSelected),
                  SizedBox(height: 16),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            onPressed: _addAppointment,
                            child: Text('Book Appointment'),
                          ),
                        ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final ProfileInfo profileInfo;

  const Profile({Key? key, required this.profileInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 219, 219, 219),
                    highlightColor: Color.fromARGB(255, 239, 239, 239),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.pexels.com/photos/6762862/pexels-photo-6762862.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileInfo.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      profileInfo.specialty,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "A doctor is a medical professional who diagnoses, treats, and prevents illnesses and injuries.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: null,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6FBFB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call_outlined),
                    color: Color(0xFF00846c),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6FBFB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.mail_outline),
                    color: Color(0xFF00846c),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6FBFB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.message_outlined),
                    color: Color(0xFF00846c),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class WorkHours extends StatefulWidget {
  final String workHours;
  final Function(DateTime dateTime) onDateTimeSelected;

  const WorkHours(
      {Key? key, required this.workHours, required this.onDateTimeSelected})
      : super(key: key);

  @override
  _WorkHoursState createState() => _WorkHoursState();
}

class _WorkHoursState extends State<WorkHours> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      transformAlignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined),
          TextButton(
            child: Text(
              DateFormat.yMMMMEEEEd().add_jm().format(_dateTime),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 43, 43, 43)),
            ),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_dateTime),
                );
                if (selectedTime != null) {
                  final dateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  setState(() {
                    _dateTime = dateTime;
                    widget.onDateTimeSelected(dateTime);
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class ProfileInfo {
  final String specialty;
  final String name;
  final String city;
  final String country;
  final String state;
  final String address;

  ProfileInfo(
      {required this.specialty,
      required this.name,
      required this.city,
      required this.country,
      required this.state,
      required this.address});
}
