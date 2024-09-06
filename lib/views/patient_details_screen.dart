import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  List<Map<String, dynamic>> getPatientData() {
    return [
      {
        'heartRate': 72,
        'steps': 5000,
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'heartRate': 85,
        'steps': 7000,
        'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      },
      {
        'heartRate': 90,
        'steps': 6500,
        'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      },
      {
        'heartRate': 78,
        'steps': 8000,
        'timestamp': DateTime.now().subtract(const Duration(days: 4)),
      },
      {
        'heartRate': 60,
        'steps': 3000,
        'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final patientData = getPatientData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: patientData.isEmpty
          ? const Center(child: Text('No data found for this patient!'))
          : ListView.builder(
              itemCount: patientData.length,
              itemBuilder: (context, index) {
                final dataPoint = patientData[index];

                // Formatting date
                final formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                    .format(dataPoint['timestamp']);

                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text('Heart Rate: ${dataPoint['heartRate']} bpm'),
                  subtitle: Text('Steps: ${dataPoint['steps']}'),
                  trailing: Text(formattedDate),
                );
              },
            ),
    );
  }
}
