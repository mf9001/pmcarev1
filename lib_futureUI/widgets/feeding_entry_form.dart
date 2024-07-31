import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/feeding_entry.dart';

class FeedingEntryForm extends StatefulWidget {
  final Function(FeedingEntry) onSave;
  final FeedingEntry? entry;

  FeedingEntryForm({required this.onSave, this.entry});

  @override
  _FeedingEntryFormState createState() => _FeedingEntryFormState();
}

class _FeedingEntryFormState extends State<FeedingEntryForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startTime;
  late DateTime _endTime;
  String _type = 'Breastfeeding';
  final TextEditingController _detailsController = TextEditingController();
  String? _breast;
  final TextEditingController _amountController = TextEditingController();
  String? _unit;

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
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
                        }
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
