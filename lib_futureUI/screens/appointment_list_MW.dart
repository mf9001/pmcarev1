import 'package:flutter/material.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

List<Appointment> upcomingAppointments = [
  Appointment(
      patientName: "Baby Anne",
      date: DateTime.now().add(Duration(days: 1)),
      details: "Feeding Issue"),
  Appointment(
      patientName: "Baby Kyle",
      date: DateTime.now().add(Duration(days: 2)),
      details: "Regular visit"),
  // Add more sample appointments here
];

class UpcomingAppointmentsScreen extends StatelessWidget {
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 191, 182),
      appBar: AppBar(
        title: Text('Upcoming Appointments'),
      ),
      body: ListView.builder(
        itemCount: upcomingAppointments.length,
        itemBuilder: (context, index) {
          final appointment = upcomingAppointments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                leading: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 87, 176, 182),
                  size: 40,
                ),
                title: Text(
                  appointment.patientName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Date: ${formatDate(appointment.date)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      appointment.details,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () {
                  // Handle tap if necessary
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
