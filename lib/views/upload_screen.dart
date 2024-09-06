import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Health Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(children: [
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 13.0,
              percent: 0.4,
              center: const Text(
                '40%',
                style: TextStyle(fontSize: 30),
              ),
              progressColor: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Started Uploading');
                },
                child: const Text('Start Upload', style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Navigate to Patients');
                },
                child: const Text('View Patients', style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
