import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/feeding_entry.dart';
import 'package:http/http.dart' as http;

class VisitsEntryForm extends StatefulWidget {
  final FeedingEntry? entry;
  VisitsEntryForm({this.entry});

  @override
  State<VisitsEntryForm> createState() => _FeedingEntryFormState();
}

class _FeedingEntryFormState extends State<VisitsEntryForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startTime;
  late DateTime _endTime;
  String _type = 'Breastfeeding';
  final TextEditingController _detailsController = TextEditingController();
  String? _breast;
  final TextEditingController _amountController = TextEditingController();
  String? _unit;

  Future _save_details(context) async {
    String _detailsController_text = _detailsController.text;
    String _amountController_text = _amountController.text;

    if (_type == 'Breastfeeding') {
      _unit = "NA";
      _amountController_text = "NA";
    }
    if (_type == 'Bottle Feeding (Pumped Milk)') {
      _breast = "NA";
    }
    if (_type == 'Bottle Feeding (Formula)') {
      _breast = "NA";
    }

    Duration duration = _endTime.difference(_startTime);
    int durationInMins = duration.inMinutes;

    final DateFormat formatter = DateFormat('yyyy-MM-dd H:m');
    final String _f_sdate = formatter.format(_startTime);
    final String _f_edate = formatter.format(_endTime);
    print(_f_sdate);
    print(_f_edate);

    var data_string =
        "$_f_sdate/$_f_edate/$durationInMins/$_type/$_breast/$_amountController_text/$_unit/$_detailsController_text";
    print("data_string" + data_string);
    var response = await http.get(
        Uri.http('10.0.2.2:5000', 'feeding/new_entry/P555/' + data_string));

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
      _endTime = widget.entry!.endTime;
      _type = widget.entry!.type;
      _detailsController.text = widget.entry!.details;
      _breast = widget.entry!.breast;
      if (widget.entry!.amount != null) {
        _amountController.text = widget.entry!.amount.toString();
      }
      _unit = widget.entry!.unit;
    } else {
      _startTime = DateTime.now();
      _endTime = DateTime.now();
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
                'Start Time',
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
                      hintText: DateFormat.yMMMd().add_jm().format(_startTime),
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
                'End Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 75, 74, 74),
                ),
              ),
              GestureDetector(
                onTap: () => _selectDateTime(context, _endTime, (dateTime) {
                  setState(() {
                    _endTime = dateTime;
                  });
                }),
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: DateFormat.yMMMd().add_jm().format(_endTime),
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
                'Feeding Type',
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
                    value: 'Breastfeeding',
                    child: Text('Breastfeeding'),
                  ),
                  DropdownMenuItem(
                    value: 'Bottle Feeding (Formula)',
                    child: Text('Bottle Feeding (Formula)'),
                  ),
                  DropdownMenuItem(
                    value: 'Bottle Feeding (Pumped Milk)',
                    child: Text('Bottle Feeding (Pumped Milk)'),
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
              if (_type == 'Breastfeeding') ...[
                SizedBox(height: 16),
                Text(
                  'Breast',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 74, 74),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _breast,
                  items: [
                    DropdownMenuItem(
                      value: 'left',
                      child: Text('Left'),
                    ),
                    DropdownMenuItem(
                      value: 'right',
                      child: Text('Right'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _breast = value;
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
              ],
              if (_type.contains('Bottle Feeding')) ...[
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
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
                      value: 'ml',
                      child: Text('ml'),
                    ),
                    DropdownMenuItem(
                      value: 'oz',
                      child: Text('oz'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _unit = value;
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
              ],
              SizedBox(height: 16),
              Text(
                'Details',
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
                        await _save_details(context);
                        /*if (_formKey.currentState!.validate()) {
                            final newEntry = FeedingEntry(
                              startTime: _startTime,
                              endTime: _endTime,
                              type: _type,
                              details: _detailsController.text,
                              breast: _type == 'Breastfeeding' ? _breast : null,
                              amount: _type.contains('Bottle Feeding')
                                  ? double.tryParse(_amountController.text)
                                  : null,
                              unit:
                                  _type.contains('Bottle Feeding') ? _unit : null,
                            );
                            widget.onSave(newEntry);
                            Navigator.pop(context);
                          }*/
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Color.fromARGB(255, 87, 176, 182),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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
