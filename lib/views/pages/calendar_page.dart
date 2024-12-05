import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
  
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Map<DateTime, List<Map<String, dynamic>>> _events = {};
  DateTime _selectedDay = DateTime.now();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedRecipient = 'Clients';

  final Map<String, Color> _recipientColors = {
    'Clients': Colors.blue,
    'Livreurs': Colors.green,
    'Admins': Colors.red,
    'Restaurants': Colors.orange,
    'All': Colors.purple,
    'Myself': Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendrier des Evènements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              eventLoader: _getEventsForDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showEventListDialog();
              },
            ),
            Expanded(
              child: ListView(
                children: _getEventsForDay(_selectedDay)
                    .map((event) => ListTile(
                          title: Text(event['title']),
                          subtitle: Text(event['description']),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(event['date']),
                              Text(
                                event['recipient'],
                                style: TextStyle(color: _recipientColors[event['recipient']]),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _showEventListDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Events on ${_selectedDay.toLocal()}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._getEventsForDay(_selectedDay).map((event) => ListTile(
                    title: Text(event['title']),
                    subtitle: Text(event['description']),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(event['date']),
                        Text(
                          event['recipient'],
                          style: TextStyle(color: _recipientColors[event['recipient']]),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showRecipientSelectionDialog();
              },
              child: Text('Add New Event'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showRecipientSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Recipient'),
          content: DropdownButton<String>(
            value: _selectedRecipient,
            onChanged: (String? newValue) {
              setState(() {
                _selectedRecipient = newValue!;
              });
            },
            items: _recipientColors.keys.map<DropdownMenuItem<String>>((String recipient) {
              return DropdownMenuItem<String>(
                value: recipient,
                child: Text(recipient),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEventCreationDialog();
              },
              child: Text('Next'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEventCreationDialog() {
    _titleController.clear();
    _descriptionController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Enter title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Enter description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                  setState(() {
                    final newEvent = {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'date': DateTime.now().toLocal().toString().split(' ')[0],
                      'recipient': _selectedRecipient,
                    };
                    _events[_selectedDay] = (_events[_selectedDay] ?? [])..add(newEvent);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
