import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flashcard_controller.dart';
import '../models/flashcard.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? flashcard;
  final int? index;
  final bool isEditing;

  AddEditFlashcardScreen({this.flashcard, this.index, required this.isEditing});

  @override
  _AddEditFlashcardScreenState createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _questionController.text = widget.flashcard!.question;
      _answerController.text = widget.flashcard!.answer;
    }
  }

  void _saveFlashcard() {
    final question = _questionController.text;
    final answer = _answerController.text;

    if (question.isNotEmpty && answer.isNotEmpty) {
      final flashcard = Flashcard(question: question, answer: answer);
      final flashcardController = Get.find<FlashcardController>();

      if (widget.isEditing) {
        flashcardController.editFlashcard(widget.index!, flashcard);
      } else {
        flashcardController.addFlashcard(flashcard);
      }

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Flashcard' : 'Add Flashcard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveFlashcard,
              child: Text(widget.isEditing ? 'Save Changes' : 'Add Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}
