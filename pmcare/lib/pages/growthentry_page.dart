import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/feeding_entry.dart';
import 'package:http/http.dart' as http;

class GrowthEntryForm extends StatefulWidget {
  final FeedingEntry? entry;
  GrowthEntryForm({this.entry});

  @override
  State<GrowthEntryForm> createState() => _FeedingEntryFormState();
}

class _FeedingEntryFormState extends State<GrowthEntryForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startTime;
  String _type = 'Weight';
  String _unit = 'g';
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future _save_details(context) async {
    String _detailsController_text = _detailsController.text;
    String _amountController_text = _amountController.text;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String _f_sdate = formatter.format(_startTime);
    print(_f_sdate);

    var data_string =
        "$_f_sdate/$_type/$_amountController_text/$_unit/$_detailsController_text";
    print("data_string" + data_string);
    var response = await http
        .get(Uri.http('10.0.2.2:5000', 'growth/new_entry/P555/' + data_string));

    //var jsonData = jsonDecode(response.body);
    var jsonData = response.body;

    print('jsonData' + jsonData.toString());

    if (jsonData.toString() == 'ok') {
      print("OK OK  " + jsonData.toString());

      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text("Data Added"),
                  content: const Text('A new record has been added !'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: const Text("OK"),
                      ),
                    ),
                  ]));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _startTime = widget.entry!.startTime;
      _type = widget.entry!.type;
      _detailsController.text = widget.entry!.details;
      if (widget.entry!.amount != null) {
        _amountController.text = widget.entry!.amount.toString();
      }
    } else {
      _startTime = DateTime.now();
    }
  }

  _selectDateTime(BuildContext context, DateTime initialDate,
      Function(DateTime) onSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final selectedDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );
      onSelected(selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
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
                      hintText: DateFormat('yyyy-MM-d').format(_startTime),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Parameter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _type,
                items: [
                  DropdownMenuItem(
                    value: 'Height',
                    child: Text('Height'),
                  ),
                  DropdownMenuItem(
                    value: 'Weight',
                    child: Text('Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'Head Circumference',
                    child: Text('Head Circumference'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Unit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _unit,
                items: [
                  DropdownMenuItem(
                    value: 'g',
                    child: Text('g'),
                  ),
                  DropdownMenuItem(
                    value: 'cm',
                    child: Text('cm'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _unit = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _save_details(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Color.fromARGB(255, 247, 248, 248),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 89, 231, 217),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Add space after the Save button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
