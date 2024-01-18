import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/hypothesis_info.dart';
import 'package:pasternak_frontend/screens/list_letters/list_letters_provider.dart';
import 'package:provider/provider.dart';
import '../../models/chunk_hypothesis.dart';
import '../../models/letter.dart';
import '../../models/letter_chunk.dart';
import '../../services/letters_service.dart';
import 'letter_screen_provider.dart';

class LetterScreenInitializerOld {
  Future<void> initializeData(BuildContext context, int letterId) async {
    try {
      final LetterScreenProvider letterScreenProvider = Provider.of<LetterScreenProvider>(context, listen: false);
      final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);
      LettersService lettersService = LettersService();

      // Fetch letter chunks and chunk hypotheses for the given letter
      Letter fetchedLetter = await lettersService.fetchLetterById(letterId);
      List<LetterChunk> letterChunks = await lettersService.fetchLetterChunks(letterId);

      List<List<ChunkHypothesis>> listsOfHypotheses = [];

      Box<HypothesisInfo> hypothesesInfoBox = Hive.box<HypothesisInfo>('hypothesesInfo');

      List<HypothesisInfo> hypothesesInfo = [];

      for (LetterChunk letterChunk in letterChunks) {
        try {
          List<ChunkHypothesis> chunkHypotheses = await lettersService.fetchChunkHypotheses(letterChunk.id);
          listsOfHypotheses.add(chunkHypotheses);
          for (ChunkHypothesis chunkHypothesis in chunkHypotheses) {
            // Retrieve the HypothesisInfo using hypothesisId
            HypothesisInfo? info = hypothesesInfoBox.values.firstWhere(
              (h) => h.id == chunkHypothesis.hypothesisId,
            );
            hypothesesInfo.add(info);
          }
        } catch (e) {
          print(e);
        }
      }

      letterScreenProvider.setLetterChunks(letterChunks);
      letterScreenProvider.setChunkHypotheses(listsOfHypotheses);
      letterScreenProvider.setLetter(fetchedLetter);
      letterScreenProvider.setHypotheses(listLettersProvider.selectedHypothesesIds);
      letterScreenProvider.setHypothesesInfo(hypothesesInfo);
    } catch (e) {
      print("ERROR IN LETTER INIT");
      print(e);
    }
  }
}
