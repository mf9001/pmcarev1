import 'package:flutter/material.dart';
import 'package:test_schedule/screens/vital_sign_screen.dart';
import 'package:test_schedule/screens/view_health_history.dart'; // Import the ViewHistoryScreen

class HealthMonitoringDashboard extends StatefulWidget {
  @override
  _HealthMonitoringDashboardState createState() =>
      _HealthMonitoringDashboardState();
}

class _HealthMonitoringDashboardState extends State<HealthMonitoringDashboard> {
  String selectedIndicator = 'Temperature';
  String selectedAgeGroup = '0-1 Month';
  final TextEditingController valueController = TextEditingController();

  final Map<String, String> indicatorUnits = {
    'Temperature': '°C',
    'Heart Rate': 'bpm',
    'Oxygen Saturation': '%',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 229, 235),
      appBar: AppBar(
        title: Text('Health Monitoring'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.health_and_safety, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Check Vital Signs',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Indicator',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedIndicator,
                      items: <String>[
                        'Temperature',
                        'Heart Rate',
                        'Oxygen Saturation'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedIndicator = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Age Group',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedAgeGroup,
                      items: <String>['0-1 Month', '1-6 Months', '6-12 Months']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedAgeGroup = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: valueController,
                      decoration: InputDecoration(
                        labelText:
                            'Enter ${selectedIndicator} value (${indicatorUnits[selectedIndicator]})',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VitalSignScreen(
                                indicator: selectedIndicator,
                                ageGroup: selectedAgeGroup,
                                enteredValue: valueController.text,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 9, 205, 231), // background
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'View History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Indicator',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedIndicator, // Set the default value
                      items: <String>[
                        'Temperature',
                        'Heart Rate',
                        'Oxygen Saturation'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedIndicator = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewHistoryScreen(
                                indicator: selectedIndicator,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromARGB(255, 9, 205, 231), // background
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
