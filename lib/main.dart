import 'package:flutter/material.dart';
import 'package:health_app/views/upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      home: Scaffold(
        body: UploadScreen(),
      ),
    );
  }
}
