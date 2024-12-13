import 'package:flashcard/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/flashcard_widget.dart';
import '../controllers/flashcard_controller.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flashcardController = Get.find<FlashcardController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to Add/Edit screen to add a new flashcard
              Get.to(() => AddEditFlashcardScreen(isEditing: false));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Obx(
              () => ListView.builder(
            itemCount: flashcardController.flashcards.length,
            itemBuilder: (context, index) {
              return FlashcardWidget(
                flashcard: flashcardController.flashcards[index],
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
