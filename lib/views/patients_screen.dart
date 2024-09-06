import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/controllers/upload_controller.dart';
import 'package:health_app/views/patient_details_screen.dart';
import 'package:intl/intl.dart';

class PatientsScreen extends StatelessWidget {
  final UploadController _uploadController = Get.find<UploadController>();

  PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Patients')),
      body: Obx(() {

        if (_uploadController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        }

        if (_uploadController.uploads.isEmpty) {
          return const Center(child: Text('No patients found.'));
        }

        final uploads = _uploadController.uploads;

        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            await _uploadController.fetchPatients();
          },
          child: ListView.builder(
            itemCount: uploads.length,
            itemBuilder: (context, index) {
              final upload = uploads[index];
              final formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                  .format(DateTime.parse(upload['timestamp']));

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('Patient: ${upload['user_id']}'),
                subtitle: Text('Uploaded on: $formattedDate'),
                onTap: () {
                  _uploadController.fetchPatientDetails(upload['id']);
                  Get.to(() => PatientDetailsScreen(upload['id']));
                },
                trailing: IconButton(
                  onPressed: () {
                    _uploadController.deleteUser(upload['id']);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.black,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}