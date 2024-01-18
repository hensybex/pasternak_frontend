import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
import 'package:provider/provider.dart';

import '../../models/hypothesis_info.dart';
import 'list_letters_provider.dart';

class ListLettersInitializer {
  Future<void> initializeData(BuildContext context) async {
    final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);

    try {
      // Open Hive boxes
      var letterCompositeBox = await Hive.openBox<LetterComposite>('letterComposites');
      var hypothesesInfoBox = await Hive.openBox<HypothesisInfo>('hypothesesInfo');
      var categoryInfoBox = await Hive.openBox<CategoryInfo>('categoriesInfo');

      // Retrieve data from Hive boxes
      List<LetterComposite> fetchedComposites = letterCompositeBox.values.toList();
      List<HypothesisInfo> hypothesesInfo = hypothesesInfoBox.values.toList();
      List<CategoryInfo> categoriesInfo = categoryInfoBox.values.toList();

      // Populate providers
      listLettersProvider.setCategories(categoriesInfo);
      listLettersProvider.setHypotheses(hypothesesInfo);
      listLettersProvider.setComposites(fetchedComposites);
      listLettersProvider.filterLetterComposites();
    } catch (e) {
      // Handle exceptions
    }
  }
}
