import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/feeding_entry.dart';
import '../widgets/feeding_entry_form.dart';

class FeedingLogScreen extends StatefulWidget {
  @override
  _FeedingLogScreenState createState() => _FeedingLogScreenState();
}

class _FeedingLogScreenState extends State<FeedingLogScreen> {
  final List<FeedingEntry> _feedingLog = [];

  void _addNewEntry(FeedingEntry entry) {
    setState(() {
      _feedingLog.add(entry);
    });
  }

  void _editEntry(int index, FeedingEntry entry) {
    setState(() {
      _feedingLog[index] = entry;
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      _feedingLog.removeAt(index);
    });
  }

  void _showEntryForm([int? index]) {
    FeedingEntry? entry;
    if (index != null) {
      entry = _feedingLog[index];
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FeedingEntryForm(
          onSave: (newEntry) {
            if (index != null) {
              _editEntry(index, newEntry);
            } else {
              _addNewEntry(newEntry);
            }
          },
          entry: entry,
        );
      },
    );
  }

  Map<String, List<FeedingEntry>> _groupFeedingsByDate(
      List<FeedingEntry> feedings) {
    Map<String, List<FeedingEntry>> groupedFeedings = {};
    for (var feeding in feedings) {
      String date = DateFormat.yMMMMd().format(feeding.startTime);
      if (groupedFeedings[date] == null) {
        groupedFeedings[date] = [];
      }
      groupedFeedings[date]!.add(feeding);
    }
    return groupedFeedings;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<FeedingEntry>> groupedFeedings =
        _groupFeedingsByDate(_feedingLog);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 108, 215, 230),
        elevation: 80,
        title: Text('Feeding Log',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: groupedFeedings.keys.map((String date) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date,
                  style: TextStyle(
                    color: Color.fromARGB(255, 75, 74, 74),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...groupedFeedings[date]!.map((FeedingEntry entry) {
                String title;
                String subtitle;
                if (entry.type == 'Breastfeeding') {
                  title = 'Breast (${entry.breast})';
                  final duration = entry.endTime.difference(entry.startTime);
                  subtitle = 'Duration: ${duration.inMinutes} minutes';
                } else {
                  title =
                      'Bottle (${entry.type.contains('Pumped') ? 'Pumped' : 'Formula'})';
                  subtitle = 'Amount: ${entry.amount} ${entry.unit}';
                }
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 4.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      title,
                      style: TextStyle(
                          color: Color.fromARGB(255, 75, 74, 74),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    subtitle: Text(subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: Color.fromARGB(255, 87, 176, 182)),
                          onPressed: () =>
                              _showEntryForm(_feedingLog.indexOf(entry)),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: Color.fromARGB(255, 87, 176, 182)),
                          onPressed: () =>
                              _deleteEntry(_feedingLog.indexOf(entry)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showEntryForm(),
      ),
    );
  }
}
