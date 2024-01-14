

import 'package:flutter/foundation.dart';
import '../../models/letter_chunk.dart';
import '../../models/chunk_hypothesis.dart';

class LetterScreenProvider with ChangeNotifier {
  List<LetterChunk> _letterChunks = [];
  List<ChunkHypothesis> _chunkHypotheses = [];

  List<LetterChunk> get letterChunks => _letterChunks;
  List<ChunkHypothesis> get chunkHypotheses => _chunkHypotheses;

  void setLetterChunks(List<LetterChunk> chunks) {
    _letterChunks = chunks;
    notifyListeners();
  }

  void setChunkHypotheses(List<ChunkHypothesis> hypotheses) {
    _chunkHypotheses = hypotheses;
    notifyListeners();
  }
}
