import 'package:flutter/material.dart';
import 'package:gamyam/widgets/floating_navbar.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key? key}) : super(key: key);

  @override
  _SleepTrackerScreenState createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  // Sample sleep data
  final List<Map<String, dynamic>> _sleepEntries = [
    {
      'date': 'Mar 23, 2025',
      'bedTime': '11:30 PM',
      'wakeTime': '7:30 AM',
      'duration': '8h 00m',
      'quality': 4,
    },
    {
      'date': 'Mar 22, 2025',
      'bedTime': '10:45 PM',
      'wakeTime': '6:30 AM',
      'duration': '7h 45m',
      'quality': 3,
    },
    {
      'date': 'Mar 21, 2025',
      'bedTime': '12:15 AM',
      'wakeTime': '8:00 AM',
      'duration': '7h 45m',
      'quality': 2,
    },
  ];

  // Controller for the add entry form
  final _bedTimeController = TextEditingController();
  final _wakeTimeController = TextEditingController();
  final _dateController = TextEditingController();
  double _qualityRating = 3;

  @override
  void dispose() {
    _bedTimeController.dispose();
    _wakeTimeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Sleep Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'Mar 24, 2025',
                ),
              ),
              TextField(
                controller: _bedTimeController,
                decoration: const InputDecoration(
                  labelText: 'Bed Time',
                  hintText: '11:30 PM',
                ),
              ),
              TextField(
                controller: _wakeTimeController,
                decoration: const InputDecoration(
                  labelText: 'Wake Time',
                  hintText: '7:30 AM',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Sleep Quality'),
              Slider(
                value: _qualityRating,
                min: 1,
                max: 5,
                divisions: 4,
                label: _qualityRating.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _qualityRating = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _sleepEntries.insert(0, {
                  'date': _dateController.text.isNotEmpty
                      ? _dateController.text
                      : 'Mar 24, 2025',
                  'bedTime': _bedTimeController.text.isNotEmpty
                      ? _bedTimeController.text
                      : '11:00 PM',
                  'wakeTime': _wakeTimeController.text.isNotEmpty
                      ? _wakeTimeController.text
                      : '7:00 AM',
                  'duration': '8h 00m', // In a real app, calculate this
                  'quality': _qualityRating.round(),
                });
              });
              Navigator.pop(context);
              // Reset controllers
              _dateController.clear();
              _bedTimeController.clear();
              _wakeTimeController.clear();
              _qualityRating = 3;
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  String _getQualityText(int quality) {
    switch (quality) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Sleep stats summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Avg. Sleep', '7.8h'),
                _buildStat('Avg. Quality', '3.2/5'),
                _buildStat('Best Day', 'Saturday'),
              ],
            ),
          ),
          
          // Sleep entries list
          Expanded(
            child: ListView.builder(
              itemCount: _sleepEntries.length,
              itemBuilder: (context, index) {
                final entry = _sleepEntries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry['date'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < entry['quality'] ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bed time: ${entry['bedTime']}'),
                            Text('Wake time: ${entry['wakeTime']}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Duration: ${entry['duration']}'),
                            Text(
                              'Quality: ${_getQualityText(entry['quality'])}',
                              style: TextStyle(
                                color: entry['quality'] >= 4
                                    ? Colors.green
                                    : entry['quality'] <= 2
                                        ? Colors.red
                                        : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const FloatingNavbar(),

    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.indigo.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}