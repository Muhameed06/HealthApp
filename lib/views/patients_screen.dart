import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<String> patients = [
      'John',
      'Muhamed',
      'Michael',
      'Emily',
      'Sarah'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Patients'),
      ),
      body: patients.isNotEmpty
          ? ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(patients[index]
                        [0]),
                  ),
                  title: Text(patients[index]),
                  subtitle:
                      Text('Patient ID: ${index + 1}'),
                  onTap: () {
                    debugPrint('Navigate to this user details');
                  },
                );
              },
            )
          : const Center(
              child: Text('No patients found'),
            ),
    );
  }
}
