import 'package:flashcard/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/flashcard.dart';
import '../controllers/flashcard_controller.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;
  final int index;

  FlashcardWidget({required this.flashcard, required this.index});

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 3.14159).animate(_controller);
  }

  // Flip the card when it's clicked
  void _flipCard() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;  // Toggle the flip state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,  // Flip the card on tap
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationY(_flipAnimation.value),  // Apply rotation
            alignment: Alignment.center,
            child: _flipAnimation.value < 1.5708
            // Front side (question + edit/delete buttons)
                ? Card(
              color: Colors.blueAccent,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.flashcard.question,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            // Implement edit functionality
                            Get.to(() => AddEditFlashcardScreen(
                              flashcard: widget.flashcard,
                              index: widget.index,
                              isEditing: true,
                            ));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            // Confirm delete
                            Get.defaultDialog(
                              title: "Confirm Deletion",
                              middleText: "Are you sure you want to delete this flashcard?",
                              onConfirm: () {
                                final flashcardController = Get.find<FlashcardController>();
                                flashcardController.deleteFlashcard(widget.index);
                                Get.back();
                              },
                              onCancel: () => Get.back(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            // Back side (answer)
                : Card(
              color: Colors.orangeAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Transform(
                      transform: Matrix4.rotationY(3.14159), // Mirror the answer text
                      alignment: Alignment.center,
                      child: Text(
                        widget.flashcard.answer,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
