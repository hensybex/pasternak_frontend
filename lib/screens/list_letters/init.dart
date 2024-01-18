import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
import 'package:pasternak_frontend/services/letter_composites_service.dart';
import 'package:provider/provider.dart';

import '../../models/hypothesis_info.dart';
import '../../services/letters_service.dart';
import 'list_letters_provider.dart';

class ListLettersInitializer {
  Future<void> initializeData(BuildContext context) async {
    try {
      const pageSize = 20;
      final ListLettersProvider listLettersProvider =
          Provider.of<ListLettersProvider>(context, listen: false);
      LettersService lettersService = LettersService();
      LetterCompositeService letterCompositeService = LetterCompositeService();

      // Fetch letters
      //List<Letter> letters = await lettersService.fetchLetters(0, pageSize);
      List<LetterComposite> fetchedComposites =
          await letterCompositeService.fetchLetterComposites(0, 1675);
      await letterCompositeService
          .storeLetterCompositesInHive(fetchedComposites);

      //listLettersProvider.appendFilteredLetters(letters);

      // Fetch hypotheses info
      List<HypothesisInfo> hypothesesInfo = await lettersService
          .fetchHypotheses()
          .then((list) =>
              list.map((h) => HypothesisInfo(id: h.id, name: h.name)).toList());
      Box<HypothesisInfo> hypothesesInfoBox =
          await Hive.openBox<HypothesisInfo>('hypothesesInfo');
      await hypothesesInfoBox.addAll(hypothesesInfo);

      countHypothesesAppearances(fetchedComposites, hypothesesInfo);

      // Fetch categories info
      List<CategoryInfo> categoriesInfo = await lettersService
          .fetchCategories()
          .then((list) =>
              list.map((h) => CategoryInfo(id: h.id, name: h.name)).toList());
      Box<CategoryInfo> categoryInfoBox =
          await Hive.openBox<CategoryInfo>('categoriesInfo');
      await categoryInfoBox.addAll(categoriesInfo);

      listLettersProvider.setCategories(categoriesInfo);
      listLettersProvider.setHypotheses(hypothesesInfo);
      listLettersProvider.setComposites(fetchedComposites);
    } catch (e) {
      print("Error in list_letters initializer");
      print(e);
    }
  }

  void countHypothesesAppearances(
      List<LetterComposite> composites, List<HypothesisInfo> hypotheses) {
    // Initialize a map to count appearances
    Map<int, int> countMap = {};

    for (var composite in composites) {
      composite.hypothesesCounts.forEach((id, _) {
        countMap[id] = (countMap[id] ?? 0) + 1;
      });
    }

    // Update numOfAppearances in each HypothesisInfo
    for (var hypothesis in hypotheses) {
      hypothesis.numOfAppearances = countMap[hypothesis.id] ?? 0;
    }
  }
}
