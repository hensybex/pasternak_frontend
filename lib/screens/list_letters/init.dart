import 'package:flutter/material.dart';
import 'package:pasternak_frontend/models/letter.dart';
import 'package:provider/provider.dart';

import '../../services/letters_service.dart';
import 'list_letters_provider.dart';

class ListLettersInitializer {
  Future<void> initializeData(BuildContext context) async {
    const _pageSize = 20;
    final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);
    LettersService lettersService = LettersService();

    List<Letter> letters = await lettersService.fetchLetters(0, _pageSize);
    listLettersProvider.appendFilteredLetters(letters);
  }
}
