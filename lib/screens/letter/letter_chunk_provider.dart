import 'package:flutter/foundation.dart';
import '../../models/chunk_hypothesis.dart';

class LetterScreenProvider with ChangeNotifier {
  int _currentVersion = 1;
  List<ChunkHypothesis> _hypotheses = [];

  int get currentVersion => _currentVersion;
  List<ChunkHypothesis> get hypotheses => _hypotheses;

  void setCurrentVersion(int version) {
    _currentVersion = version;
    notifyListeners();
  }

  void setHypotheses(List<ChunkHypothesis> newHypotheses) {
    _hypotheses = newHypotheses;
    notifyListeners();
  }

  void toggleHypothesisAccepted(String hypothesisId) {
    for (var hypothesis in _hypotheses) {
      if (hypothesis.hypothesisId == hypothesisId) {
        hypothesis.accepted = !hypothesis.accepted;
        break;
      }
    }
    notifyListeners();
  }
}