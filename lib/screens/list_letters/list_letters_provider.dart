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
  Set<int> selectedCategoriesIds = {};
  Set<int> selectedHypothesesIds = {};
  List<CategoryInfo> fetchedCategories = [];
  List<HypothesisInfo> fetchedHypotheses = [];
  List<LetterComposite> letterComposites = [];
  List<LetterComposite> filteredComposites = [];
  String _startYear = '';
  String _endYear = '';
  bool isInitialized = false;

  List<Letter> get filteredLettersGetter => filteredLetters;
  String get startYear => _startYear;

  String get endYear => _endYear;

  void setInitialized() {
    isInitialized = true;
  }

  set startYear(String value) {
    _startYear = value;
    notifyListeners();
  }

  set endYear(String value) {
    _endYear = value;
    notifyListeners();
  }

  void setComposites(List<LetterComposite> fetchedComposites) {
    letterComposites = fetchedComposites;
    filteredComposites = fetchedComposites;
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
    if (selectedCategoriesIds.contains(hypothesisId)) {
      selectedCategoriesIds.remove(hypothesisId);
    } else {
      selectedCategoriesIds.add(hypothesisId);
    }
    notifyListeners();
  }

  // Add or remove a hypothesis ID from the selected list
  void toggleHypothesisSelection(int hypothesisId) {
    if (selectedHypothesesIds.contains(hypothesisId)) {
      selectedHypothesesIds.remove(hypothesisId);
    } else {
      selectedHypothesesIds.add(hypothesisId);
    }
    notifyListeners();
  }

  // Clear all filters
  void clearFilters() {
    chunksAvailable = false;
    selectedHypothesesIds.clear();
    notifyListeners();
  }

  void countHypothesesAppearances() {
    // Initialize a map to count appearances
    Map<int, int> countMap = {};
    //int numOfComposites = filteredComposites.length;
    //print("NUM OF COMPOSITES: $numOfComposites");

    for (LetterComposite composite in filteredComposites) {
      composite.hypothesesCounts.forEach((id, _) {
        countMap[id] = (countMap[id] ?? 0) + 1;
      });
    }

    // Update numOfAppearances in each HypothesisInfo
    for (HypothesisInfo hypothesis in fetchedHypotheses) {
      if (hypothesis.id == 76) {
        //print(hypothesis.name);
        //print(hypothesis.id);
        //print(hypothesis.numOfAppearances);
      }
      hypothesis.numOfAppearances = countMap[hypothesis.id] ?? 0;
      if (hypothesis.id == 76) {
        //print("AFTER");
        //print(hypothesis.numOfAppearances);
      }
    }
    //notifyListeners();
  }

  void filterLetterComposites() {
    // Filter the composites based on the criteria
    var newFilteredComposites = letterComposites.where((composite) {
      // Check if any of the composite's category IDs match the selected category IDs
      bool matchesCategories = selectedCategoriesIds.isEmpty || composite.categoriesIds.any((id) => selectedCategoriesIds.contains(id));

      // Check if all the selected hypothesis IDs are contained in the composite's hypothesesCounts keys
      bool matchesHypotheses =
          selectedHypothesesIds.isEmpty || selectedHypothesesIds.every((id) => composite.hypothesesCounts.containsKey(id));

      bool matchesYearRange = true;
      if (startYear.isNotEmpty && endYear.isNotEmpty) {
        int compositeYear = int.tryParse(composite.year) ?? 0;
        int startYr = int.tryParse(startYear) ?? 0;
        int endYr = int.tryParse(endYear) ?? 0;
        matchesYearRange = compositeYear >= startYr && compositeYear <= endYr;
      }

      // Return true if the composite matches all criteria
      return matchesCategories && matchesHypotheses && matchesYearRange;
    }).toList();

    // Sort the filtered list by composite.id in ascending order
    newFilteredComposites.sort((a, b) => a.id.compareTo(b.id));

    filteredComposites = newFilteredComposites;
    countHypothesesAppearances();
    notifyListeners();
  }
}
