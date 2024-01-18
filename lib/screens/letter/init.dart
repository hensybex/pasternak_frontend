import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/chunk_hypothesis.dart';
import '../../models/letter.dart';
import '../../models/letter_chunk.dart';
import '../../services/letters_service.dart';
import 'letter_screen_provider.dart';

class LetterScreenInitializer {
  Future<void> initializeData(BuildContext context, int letterId) async {
    final LetterScreenProvider letterScreenProvider =
        Provider.of<LetterScreenProvider>(context, listen: false);
    LettersService lettersService = LettersService();

    // Fetch letter chunks and chunk hypotheses for the given letter
    Letter fetchedLetter = await lettersService.fetchLetterById(letterId);
    List<LetterChunk> letterChunks =
        await lettersService.fetchLetterChunks(letterId);

    List<List<ChunkHypothesis>> listsOfHypotheses = [];
    for (LetterChunk letterChunk in letterChunks) {
      try {
        List<ChunkHypothesis> chunkHypotheses =
            await lettersService.fetchChunkHypotheses(letterChunk.id);
        listsOfHypotheses.add(chunkHypotheses);
      } catch (e) {
        print(e);
      }
    }

    letterScreenProvider.setLetterChunks(letterChunks);
    letterScreenProvider.setChunkHypotheses(listsOfHypotheses);
    letterScreenProvider.setLetter(fetchedLetter);
  }
}
