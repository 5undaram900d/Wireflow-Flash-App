import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/flashcard_controller.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
  Get.put(FlashcardController()); // Initialize the controller
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      home: MainScreen(),
    );
  }
}
