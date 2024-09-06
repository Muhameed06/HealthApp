import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/controllers/upload_controller.dart';
import 'package:intl/intl.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String uploadId;

  PatientDetailsScreen(this.uploadId, {super.key});

  final UploadController _uploadController = Get.find<UploadController>();

  @override
  Widget build(BuildContext context) {
    _uploadController.fetchPatientDetails(uploadId);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Details')),
      body: Obx(() {
        if (_uploadController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        }

        if (_uploadController.uploadDetails.isEmpty) {
          return const Center(child: Text('No data found.'));
        }

        final dataPoints = _uploadController.uploadDetails;

        return ListView.builder(
          itemCount: dataPoints.length,
          itemBuilder: (context, index) {
            final dataPoint = dataPoints[index];
            final formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                .format(DateTime.parse(dataPoint['timestamp']));

            return ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: Text('Heart Rate: ${dataPoint['heart_rate']} bpm'),
              subtitle: Text('Steps: ${dataPoint['steps']}'),
              trailing: Text('Date: $formattedDate'),
            );
          },
        );
      }),
    );
  }
}
