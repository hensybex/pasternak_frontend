import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../models/letter_chunk.dart';
import '../models/chunk_hypothesis.dart';
import '../utils/styling_utils.dart';

class CustomTextWidget extends StatefulWidget {
  final List<LetterChunk> letterChunks;
  final List<ChunkHypothesis> chunkHypotheses;

  CustomTextWidget({required this.letterChunks, required this.chunkHypotheses});

  @override
  _CustomTextWidgetState createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    for (var chunk in widget.letterChunks) {
      spans.add(_buildChunkSpan(chunk));
    }
    return spans;
  }

  TextSpan _buildChunkSpan(LetterChunk chunk) {
    List<InlineSpan> inlineSpans = [];

    // Assuming that chunkHypotheses are sorted by their position in the text
    int lastSplitIndex = 0;
    widget.chunkHypotheses
        .where((h) => h.letterChunkId == chunk.id)
        .forEach((hypothesis) {
      // Split the chunk text based on the hypothesis position
      String beforeHypothesis =
          chunk.chunk.substring(lastSplitIndex, hypothesis.quoteStart);
      String hypothesisText =
          chunk.chunk.substring(hypothesis.quoteStart, hypothesis.quoteEnd);

      // Add non-hypothesis part
      inlineSpans.add(TextSpan(text: beforeHypothesis));

      // Add hypothesis part with styling and recognizer for hover
      inlineSpans.add(TextSpan(
        text: hypothesisText,
        style: StylingUtils.getStyleForHypothesis(
            hypothesis), // Method in StylingUtils to get styling based on hypothesis
        recognizer: TapGestureRecognizer()..onTap = () => _onHover(hypothesis),
      ));

      lastSplitIndex = hypothesis.quoteEnd;
    });

    // Add remaining part of the chunk (if any)
    if (lastSplitIndex < chunk.chunk.length) {
      inlineSpans.add(TextSpan(text: chunk.chunk.substring(lastSplitIndex)));
    }

    return TextSpan(children: inlineSpans);
  }

  void _onHover(ChunkHypothesis hypothesis) {
    // Display a popup with details of the hypothesis
    // For example, using a Flutter package like 'flutter_tooltip'
    /* Tooltip.show(
      context,
      text:
          'Hypothesis: ${hypothesis.hypothesisId}\nVersion: ${hypothesis.version}\nAccepted: ${hypothesis.accepted}',
      target: GestureDetector(
        onTap: () => _toggleHypothesisAccepted(hypothesis),
        child: Text(hypothesis.proof,
            style: TextStyle(decoration: TextDecoration.underline)),
      ),
    ); */
  }

  void _toggleHypothesisAccepted(ChunkHypothesis hypothesis) {
    setState(() {
      hypothesis.accepted = !hypothesis.accepted;
    });
  }
}
