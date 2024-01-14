import 'package:flutter/material.dart';
import 'package:pasternak_frontend/models/chunk_hypothesis.dart';

class StylingUtils {
  static TextStyle getStyleForHypothesis(ChunkHypothesis hypothesis) {
    // Example styling based on hypothesis version
    // You can customize this based on your needs
    switch (hypothesis.version) {
      case 1:
        return TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
      case 2:
        return TextStyle(color: Colors.blue, fontStyle: FontStyle.italic);
      default:
        return TextStyle(color: Colors.grey);
    }
  }
}
