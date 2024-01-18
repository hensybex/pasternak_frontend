import 'package:flutter/foundation.dart';
import 'package:pasternak_frontend/models/hypothesis_info.dart';
import '../../models/letter.dart';
import '../../models/letter_chunk.dart';
import '../../models/chunk_hypothesis.dart';

class LetterScreenProvider with ChangeNotifier {
  List<LetterChunk> _letterChunks = [];
  List<List<ChunkHypothesis>> _chunkHypotheses = [];
  Letter letter = Letter(id: 0, createdAt: DateTime.now());
  Set<int> selectedHypotheses = {};
  List<HypothesisInfo> hypothesesInfo = [];

  List<LetterChunk> get letterChunks => _letterChunks;
  List<List<ChunkHypothesis>> get chunkHypotheses => _chunkHypotheses;

  void setHypotheses(Set<int> incomingHypotheses) {
    selectedHypotheses = incomingHypotheses;
    notifyListeners();
  }

  void setHypothesesInfo(List<HypothesisInfo> fetchedHypothesesInfo) {
    hypothesesInfo = fetchedHypothesesInfo;
    notifyListeners();
  }

  void toggleHypothesisSelection(int hypothesisId) {
    if (selectedHypotheses.contains(hypothesisId)) {
      selectedHypotheses.remove(hypothesisId);
    } else {
      selectedHypotheses.add(hypothesisId);
    }
    notifyListeners();
  }

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
