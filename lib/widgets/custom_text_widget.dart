import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../models/hypothesis_info.dart';
import '../models/letter_chunk.dart';
import '../models/chunk_hypothesis.dart';
import '../screens/letter/letter_screen_provider.dart';

class CustomTextWidget extends StatelessWidget {
  final List<LetterChunk> letterChunks;
  final List<List<ChunkHypothesis>> chunkHypotheses;

  CustomTextWidget({required this.letterChunks, required this.chunkHypotheses});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _buildTextSpans(context),
        style: const TextStyle(
          fontFamily: 'PT Serif',
          fontSize: 18,
        ),
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(BuildContext context) {
    List<InlineSpan> spans = [];

    final LetterScreenProvider letterScreenProvider = Provider.of<LetterScreenProvider>(context, listen: false);

    for (int i = 0; i < letterChunks.length; i++) {
      final chunk = letterChunks[i];
      final hypotheses = chunkHypotheses[i];

      int currentIndex = 0;
      hypotheses.sort((a, b) => a.quoteStart.compareTo(b.quoteStart));

      for (int j = 0; j < hypotheses.length; j++) {
        var hypothesis = hypotheses[j];

        // Fetch hypothesis name from Hive box
        String consolidatedNames = getHypothesisName(hypothesis.hypothesisId);
        int end = hypothesis.quoteEnd;
        bool isAnyHypothesisSelected = letterScreenProvider.selectedHypotheses.contains(hypothesis.hypothesisId);

        while (j + 1 < hypotheses.length && hypotheses[j + 1].quoteStart <= end) {
          end = max(end, hypotheses[j + 1].quoteEnd);

          // Fetch the next hypothesis name
          String nextHypothesisName = getHypothesisName(hypotheses[j + 1].hypothesisId);
          consolidatedNames += ', $nextHypothesisName';

          if (letterScreenProvider.selectedHypotheses.contains(hypotheses[j + 1].hypothesisId)) {
            isAnyHypothesisSelected = true;
          }

          j++;
        }

        // Text before the hypothesis
        if (currentIndex < hypothesis.quoteStart) {
          spans.add(TextSpan(text: chunk.chunk.substring(currentIndex, hypothesis.quoteStart)));
        }

        // Hypothesis text
        var hypothesisText = chunk.chunk.substring(hypothesis.quoteStart, end);
        spans.add(WidgetSpan(
          child: GestureDetector(
            onTap: () => _showHypothesisPopup(context, consolidatedNames),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Consumer<LetterScreenProvider>(builder: (context, letterScreenProvider, child) {
                return Text(
                  hypothesisText,
                  style: TextStyle(
                    backgroundColor: isAnyHypothesisSelected ? Colors.blue : Colors.grey,
                    fontFamily: 'PT Serif',
                  ),
                );
              }),
            ),
          ),
        ));

        currentIndex = end;
      }

      // Remaining text after the last hypothesis
      if (currentIndex < chunk.chunk.length) {
        spans.add(TextSpan(text: chunk.chunk.substring(currentIndex)));
      }
    }

    return spans;
  }

  void checkHypothesisInfo(int hypothesisId) async {
    var hypothesesInfoBox = Hive.box<HypothesisInfo>('hypothesesInfoBox');

    for (HypothesisInfo hypothesisInfo in hypothesesInfoBox.values) {
      if (hypothesisInfo.id == hypothesisId) {
        print('TRUE ${hypothesisInfo.name}');
        break; // Exit the loop once the matching ID is found
      }
    }
  }

  String getHypothesisName(int hypothesisId) {
    Box<HypothesisInfo> hypothesesInfoBox = Hive.box<HypothesisInfo>('hypothesesInfo');

    //var hypothesisInfo = hypothesesInfoBox.values.firstWhere(hypothesisId);
    HypothesisInfo? hypothesisInfo = hypothesesInfoBox.values.firstWhere(
      (h) => h.id == hypothesisId,
    );
    if (hypothesisInfo != null) {
      return hypothesisInfo.name;
    } else {
      return "Unknown";
    }
  }

  void _showHypothesisPopup(BuildContext context, String hypothesisName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hypothesisName),
          // Other dialog properties
        );
      },
    );
  }
}
