import 'package:flutter/material.dart';

class VitalSignScreen extends StatelessWidget {
  final String indicator;
  final String ageGroup;
  final String enteredValue;

  VitalSignScreen({
    required this.indicator,
    required this.ageGroup,
    required this.enteredValue,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    IconData icon;
    String normalRange;

    switch (indicator) {
      case 'Heart Rate':
        title = 'Heart Beat';
        icon = Icons.favorite;
        normalRange = _getNormalRange(indicator, ageGroup);
        break;
      case 'Temperature':
        title = 'Temperature';
        icon = Icons.thermostat;
        normalRange = _getNormalRange(indicator, ageGroup);
        break;
      case 'Oxygen Saturation':
        title = 'Oxygen Saturation';
        icon = Icons.brightness_high;
        normalRange = _getNormalRange(indicator, ageGroup);
        break;
      default:
        title = 'Indicator';
        icon = Icons.device_unknown;
        normalRange = 'Unknown';
    }

    bool isNormal = _isNormal(indicator, ageGroup, enteredValue);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 9, 205, 231),
      ),
      body: Container(
        color: Color.fromARGB(255, 167, 212, 218),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 162, 229, 238),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.teal,
                    size: 80,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Entered $title: $enteredValue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Normal: ${isNormal ? 'Yes' : 'No'}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: isNormal ? Colors.green : Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Normal Range: $normalRange',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getNormalRange(String indicator, String ageGroup) {
    Map<String, Map<String, String>> normalRanges = {
      'Heart Rate': {
        '0-1 Month': '80-160 bpm',
        '1-6 Months': '80-140 bpm',
        '6-12 Months': '80-130 bpm',
      },
      'Temperature': {
        '0-1 Month': '36.5-37.5°C',
        '1-6 Months': '36.5-37.5°C',
        '6-12 Months': '36.5-37.5°C',
      },
      'Oxygen Saturation': {
        '0-1 Month': '95-100%',
        '1-6 Months': '95-100%',
        '6-12 Months': '95-100%',
      },
    };

    return normalRanges[indicator]?[ageGroup] ?? 'Unknown';
  }

  bool _isNormal(String indicator, String ageGroup, String value) {
    String normalRange = _getNormalRange(indicator, ageGroup);
    if (normalRange == 'Unknown') {
      return false;
    }

    List<String> rangeParts = normalRange.split(' ')[0].split('-');
    double min = double.tryParse(rangeParts[0]) ?? 0;
    double max = double.tryParse(rangeParts[1]) ?? 0;
    double entered = double.tryParse(value) ?? 0;

    return entered >= min && entered <= max;
  }
}
