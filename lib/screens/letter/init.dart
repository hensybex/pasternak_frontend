import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/chunk_hypothesis.dart';
import '../../models/letter_chunk.dart';
import '../../services/letters_service.dart';
import 'letter_screen_provider.dart';

class LetterScreenInitializer {
  Future<void> initializeData(BuildContext context, int letterId) async {
    final LetterScreenProvider letterScreenProvider = Provider.of<LetterScreenProvider>(context, listen: false);
    LettersService lettersService = LettersService();

    // Fetch letter chunks and chunk hypotheses for the given letter
    List<LetterChunk> letterChunks = await lettersService.fetchLetterChunks(letterId);
    List<List<ChunkHypothesis>> listsOfHypotheses = [];
    for (LetterChunk letterChunk in letterChunks) {
      List<ChunkHypothesis> chunkHypotheses = await lettersService.fetchChunkHypotheses(letterChunk.id!);
      listsOfHypotheses.add(chunkHypotheses);
    }

    letterScreenProvider.setLetterChunks(letterChunks);
    //letterScreenProvider.setChunkHypotheses(chunkHypotheses);
  }
}
