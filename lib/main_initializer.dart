import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
import 'package:pasternak_frontend/services/letter_composites_service.dart';

import '../../models/hypothesis_info.dart';
import '../../services/letters_service.dart';

Future<void> initializeData() async {
  try {
    print("MAIN INITIALIZER TRIGGERED");
    LettersService lettersService = LettersService();
    LetterCompositeService letterCompositeService = LetterCompositeService();

    // Fetch letters
    //List<Letter> letters = await lettersService.fetchLetters(0, pageSize);
    List<LetterComposite> fetchedComposites = await letterCompositeService.fetchLetterComposites(0, 1675);
    await letterCompositeService.storeLetterCompositesInHive(fetchedComposites);

    // Fetch hypotheses info
    List<HypothesisInfo> hypothesesInfo =
        await lettersService.fetchHypotheses().then((list) => list.map((h) => HypothesisInfo(id: h.id, name: h.name)).toList());
    Box<HypothesisInfo> hypothesesInfoBox = await Hive.openBox<HypothesisInfo>('hypothesesInfo');
    await hypothesesInfoBox.clear();
    await hypothesesInfoBox.addAll(hypothesesInfo);

    // Fetch categories info
    List<CategoryInfo> categoriesInfo =
        await lettersService.fetchCategories().then((list) => list.map((h) => CategoryInfo(id: h.id, name: h.name)).toList());
    Box<CategoryInfo> categoryInfoBox = await Hive.openBox<CategoryInfo>('categoriesInfo');
    await categoryInfoBox.clear();
    await categoryInfoBox.addAll(categoriesInfo);
  } catch (e) {}
}
