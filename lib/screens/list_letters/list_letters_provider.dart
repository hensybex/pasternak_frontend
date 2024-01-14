import 'package:flutter/material.dart';
import 'package:pasternak_frontend/models/letter.dart';

class ListLettersProvider extends ChangeNotifier {
  List<Letter> filteredLetters = [];
  int pageIndex = 0;
  bool isLoading = false;

  List<Letter> get filteredLettersGetter => filteredLetters;

  void clearFilteredLetters() {
    filteredLetters.clear();
    notifyListeners();
  }

  void appendFilteredLetters(List<Letter> uploadedLetters) {
    filteredLetters.addAll(uploadedLetters);
    notifyListeners();
  }

  void incrementPageIndex() {
    pageIndex++;
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
