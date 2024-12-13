import 'package:get/get.dart';
import '../models/flashcard.dart';

class FlashcardController extends GetxController {
  var flashcards = <Flashcard>[].obs;  // Observable list of flashcards

  // Function to add a flashcard
  void addFlashcard(Flashcard flashcard) {
    flashcards.add(flashcard);
  }

  // Function to delete a flashcard by index
  void deleteFlashcard(int index) {
    flashcards.removeAt(index);
  }

  // Function to edit a flashcard
  void editFlashcard(int index, Flashcard flashcard) {
    flashcards[index] = flashcard;
  }
}
