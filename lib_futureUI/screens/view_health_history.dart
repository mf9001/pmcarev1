import 'package:flutter/material.dart';

class ViewHistoryScreen extends StatelessWidget {
  final String indicator;

  ViewHistoryScreen({required this.indicator});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Map<String, String>> historyData = [
      {'date': 'July 24, 2024', 'value': '36.5°C', 'normal': 'Yes'},
      {'date': 'July 23, 2024', 'value': '37.0°C', 'normal': 'Yes'},
      {'date': 'July 22, 2024', 'value': '38.0°C', 'normal': 'No'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$indicator History',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 246, 246),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 108, 215, 230),
      ),
      body: Container(
        color: const Color.fromARGB(255, 234, 241, 241),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            final data = historyData[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  data['date']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 9, 205, 231),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Value: ${data['value']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 88, 90, 90),
                      ),
                    ),
                    Text(
                      'Normal: ${data['normal']}',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            data['normal'] == 'Yes' ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(
                  data['normal'] == 'Yes' ? Icons.check_circle : Icons.warning,
                  color: data['normal'] == 'Yes' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
