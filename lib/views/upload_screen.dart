import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/controllers/upload_controller.dart';
import 'package:health_app/core/helpers/data_helper.dart';
import 'package:health_app/models/user_health.dart';
import 'package:health_app/views/patients_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UploadScreen extends StatelessWidget {
  final UploadController _uploadController = Get.put(UploadController());

  UploadScreen({super.key});

  final List<UserHealthModel> mockData = DataHelper.generateMockData(10000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Health Data')),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              Obx(() => CircularPercentIndicator(
                    radius: 90.0,
                    lineWidth: 13.0,
                    percent: _uploadController.progress.value,
                    center: Text(
                      "${(_uploadController.progress.value * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(fontSize: 20),
                    ),
                    progressColor: Colors.red,
                    animation: true,
                    animateFromLastPercent: true,
                  )),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: _uploadController.isUploading.value
                      ? null
                      : () => _uploadController.uploadData(mockData),
                  child: const Text('Start Upload', style: TextStyle(color: Colors.black, fontSize: 16),),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => PatientsScreen()),
                  child: const Text('View Uploads', style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}