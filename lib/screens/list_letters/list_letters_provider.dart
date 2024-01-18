import 'package:flutter/material.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/letter.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';

import '../../models/hypothesis_info.dart';

class ListLettersProvider extends ChangeNotifier {
  List<Letter> filteredLetters = [];
  int pageIndex = 0;
  bool isLoading = false;
  bool chunksAvailable = false;
  Set<int> selectedCategories = {};
  Set<int> selectedHypotheses = {};
  List<CategoryInfo> fetchedCategories = [];
  List<HypothesisInfo> fetchedHypotheses = [];
  List<LetterComposite> letterComposites = [];

  List<Letter> get filteredLettersGetter => filteredLetters;

  void setComposites(List<LetterComposite> fetchedComposites) {
    letterComposites = fetchedComposites;
    notifyListeners();
  }

  void clearFilteredLetters() {
    filteredLetters.clear();
    notifyListeners();
  }

  void setHypotheses(List<HypothesisInfo> newHypotheses) {
    fetchedHypotheses = newHypotheses;
    notifyListeners();
  }

  void setCategories(List<CategoryInfo> newCategories) {
    fetchedCategories = newCategories;
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

  // Setter for chunksAvailable filter
  void setChunksAvailable(bool value) {
    chunksAvailable = value;
    notifyListeners();
  }

  void toggleCategoriesSelection(int hypothesisId) {
    if (selectedCategories.contains(hypothesisId)) {
      selectedCategories.remove(hypothesisId);
    } else {
      selectedCategories.add(hypothesisId);
    }
    notifyListeners();
  }

  // Add or remove a hypothesis ID from the selected list
  void toggleHypothesisSelection(int hypothesisId) {
    if (selectedHypotheses.contains(hypothesisId)) {
      selectedHypotheses.remove(hypothesisId);
    } else {
      selectedHypotheses.add(hypothesisId);
    }
    notifyListeners();
  }

  // Clear all filters
  void clearFilters() {
    chunksAvailable = false;
    selectedHypotheses.clear();
    notifyListeners();
  }
}
