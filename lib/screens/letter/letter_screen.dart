import 'package:flutter/material.dart';
import 'package:pasternak_frontend/screens/letter/letter_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../models/letter.dart';
import '../../widgets/custom_text_widget.dart';
import 'init.dart';

class LetterScreen extends StatefulWidget {
  final Letter letter;

  const LetterScreen({super.key, required this.letter});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = LetterScreenInitializer().initializeData(context, widget.letter.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Letter ${widget.letter.sentTo}')),
      body: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<LetterScreenProvider>(builder: (context, letterScreenProvider, child) {
              return Column(
                children: [
                  Text(widget.letter.location),
                  Text(widget.letter.sentAt),
                  CustomTextWidget(letterChunks: letterScreenProvider.letterChunks, chunkHypotheses: letterScreenProvider.chunkHypotheses),
                ],
              );
            }
          );
        }
      ),
    );
  }
}
