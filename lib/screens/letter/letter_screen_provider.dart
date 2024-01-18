import 'package:flutter/foundation.dart';
import '../../models/letter.dart';
import '../../models/letter_chunk.dart';
import '../../models/chunk_hypothesis.dart';

class LetterScreenProvider with ChangeNotifier {
  List<LetterChunk> _letterChunks = [];
  List<List<ChunkHypothesis>> _chunkHypotheses = [];
  Letter letter = Letter(id: 0, createdAt: DateTime.now());

  List<LetterChunk> get letterChunks => _letterChunks;
  List<List<ChunkHypothesis>> get chunkHypotheses => _chunkHypotheses;

  void setLetter(Letter fetchedLetter) {
    letter = fetchedLetter;
    notifyListeners();
  }

  void setLetterChunks(List<LetterChunk> chunks) {
    _letterChunks = chunks;
    notifyListeners();
  }

  void setChunkHypotheses(List<List<ChunkHypothesis>> hypotheses) {
    _chunkHypotheses = hypotheses;
    notifyListeners();
  }
}
