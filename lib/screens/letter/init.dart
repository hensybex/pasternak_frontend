import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/models/hypothesis_info.dart';
import 'package:pasternak_frontend/screens/list_letters/list_letters_provider.dart';
import 'package:provider/provider.dart';
import '../../models/chunk_hypothesis.dart';
import '../../models/letter.dart';
import '../../models/letter_chunk.dart';
import 'letter_screen_provider.dart';

class LetterScreenInitializer {
  Future<void> initializeData(BuildContext context, int letterId) async {
    try {
      final LetterScreenProvider letterScreenProvider = Provider.of<LetterScreenProvider>(context, listen: false);
      final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);

      // Retrieve the letter and its chunks from Hive

      final Box<Letter> lettersBox = await Hive.openBox<Letter>('letters');
      print("OPENED LETTER BOX");
      Letter fetchedLetter = lettersBox.values.firstWhere((letter) => letter.id == letterId);

      Box<LetterChunk> letterChunksBox = Hive.box<LetterChunk>('letter_chunks');
      List<LetterChunk> letterChunks = letterChunksBox.values.where((chunk) => chunk.letterId == letterId).toList();

      List<List<ChunkHypothesis>> listsOfHypotheses = [];
      final Box<HypothesisInfo> hypothesesInfoBox = await Hive.openBox<HypothesisInfo>('hypotheses_info');
      print("OPENED HYPOTHESESINFO BOX");
      List<HypothesisInfo> hypothesesInfo = [];

      for (LetterChunk letterChunk in letterChunks) {
        try {
          // Assuming you have a Box for ChunkHypothesis
          final Box<ChunkHypothesis> chunkHypothesesBox = await Hive.openBox<ChunkHypothesis>('chunk_hypotheses');
          print("OPENED CHUNK HYPOTHESES BOX");
          List<ChunkHypothesis> chunkHypotheses =
              chunkHypothesesBox.values.where((hypothesis) => hypothesis.letterChunkId == letterChunk.id).toList();
          listsOfHypotheses.add(chunkHypotheses);

          for (ChunkHypothesis chunkHypothesis in chunkHypotheses) {
            // Retrieve the HypothesisInfo using hypothesisId
            HypothesisInfo info = hypothesesInfoBox.values.firstWhere((h) => h.id == chunkHypothesis.hypothesisId);
            hypothesesInfo.add(info);
          }
        } catch (e) {
          print(e);
        }
      }

      letterScreenProvider.setLetter(fetchedLetter);
      letterScreenProvider.setLetterChunks(letterChunks);
      letterScreenProvider.setChunkHypotheses(listsOfHypotheses);
      letterScreenProvider.setHypotheses(listLettersProvider.selectedHypothesesIds);
      letterScreenProvider.setHypothesesInfo(hypothesesInfo);
    } catch (e) {
      print("ERROR IN LETTER INIT");
      print(e);
    }
  }
}
