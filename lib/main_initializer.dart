import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:pasternak_frontend/models/category.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/chunk_hypothesis.dart';
import 'package:pasternak_frontend/models/letter.dart';
import 'package:pasternak_frontend/models/letter_chunk.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
//import 'package:pasternak_frontend/services/letter_composites_service.dart';

import '../../models/hypothesis_info.dart';
//import '../../services/letters_service.dart';

Future<void> initializeData() async {
  try {
    print("Start of initialization");
    String jsonString = await rootBundle.loadString('categories.json');
    List<dynamic> jsonData = json.decode(jsonString);
    final Box<CategoryInfo> categoriesBox = await Hive.openBox<CategoryInfo>('categories_info');
    await categoriesBox.clear();
    List<CategoryInfo> categories = jsonData.map((item) => CategoryInfo.fromJson(item)).toList();
    await categoriesBox.addAll(categories);

    print("Processed categories");

    jsonString = await rootBundle.loadString('chunk_hypotheses.json');
    jsonData = json.decode(jsonString);
    final Box<ChunkHypothesis> chunkHypothesesBox = await Hive.openBox<ChunkHypothesis>('chunk_hypotheses');
    await chunkHypothesesBox.clear();
    List<ChunkHypothesis> chunkHypotheses = jsonData.map((item) => ChunkHypothesis.fromMap(item)).toList();
    await chunkHypothesesBox.addAll(chunkHypotheses);

    print("Processed chunk_hypotheses");

    jsonString = await rootBundle.loadString('hypotheses.json');
    jsonData = json.decode(jsonString);
    final Box<HypothesisInfo> hypothesesBox = await Hive.openBox<HypothesisInfo>('hypotheses_info');
    await hypothesesBox.clear();
    List<HypothesisInfo> hypotheses = jsonData.map((item) => HypothesisInfo.fromJson(item)).toList();
    await hypothesesBox.addAll(hypotheses);

    print("Processed hypotheses");

    jsonString = await rootBundle.loadString('letter_chunks.json');
    jsonData = json.decode(jsonString);
    final Box<LetterChunk> letterChunksBox = await Hive.openBox<LetterChunk>('letter_chunks');
    await letterChunksBox.clear();
    List<LetterChunk> letterChunks = jsonData.map((item) => LetterChunk.fromMap(item)).toList();
    await letterChunksBox.addAll(letterChunks);

    print("Processed letter_chunks");

    jsonString = await rootBundle.loadString('letter_composites.json');
    jsonData = json.decode(jsonString);
    final Box<LetterComposite> letterCompositesBox = await Hive.openBox<LetterComposite>('letter_composites');
    await letterCompositesBox.clear();
    List<LetterComposite> letterComposites = jsonData.map((item) => LetterComposite.fromMap(item)).toList();
    await letterCompositesBox.addAll(letterComposites);

    print("Processed letter_composites");

    jsonString = await rootBundle.loadString('letters.json');
    jsonData = json.decode(jsonString);
    final Box<Letter> lettersBox = await Hive.openBox<Letter>('letters');
    await lettersBox.clear();
    List<Letter> letters = jsonData.map((item) => Letter.fromMap(item)).toList();
    await lettersBox.addAll(letters);

    print("Processed letters");

    /* LettersService lettersService = LettersService();
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
    await categoryInfoBox.addAll(categoriesInfo); */
  } catch (e) {
    print("CAUGHT ERROR");
    print(e);
  }
}
