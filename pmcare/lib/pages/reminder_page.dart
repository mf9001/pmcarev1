import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderPage extends StatefulWidget {
  final ReminderPage? entry;
  ReminderPage({this.entry});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  late DateTime _startTime;
  _selectDateTime(BuildContext context, DateTime initialDate,
      Function(DateTime) onSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (time != null) {
        final selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        onSelected(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 222, 222),
        appBar: AppBar(
          title: const Text(
            'Reminders',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 87, 176, 182),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDateTime(context, _startTime, (dateTime) {
                setState(() {
                  _startTime = dateTime;
                });
              }),
              child: AbsorbPointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: DateFormat.yMMMd().add_jm().format(_startTime),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Set Reminder"))
          ],
        )),
      ),
    );
  }
}
