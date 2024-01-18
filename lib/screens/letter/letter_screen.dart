import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasternak_frontend/screens/letter/letter_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_text_widget.dart';
import 'init.dart';

class LetterScreen extends StatefulWidget {
  final int letterId;

  const LetterScreen({super.key, required this.letterId});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture =
        LetterScreenInitializer().initializeData(context, widget.letterId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<LetterScreenProvider>(
              builder: (context, letterScreenProvider, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Letter ${letterScreenProvider.letter.sentTo}'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.go('/');
                      },
                      icon: Icon(Icons.back_hand))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(letterScreenProvider.letter.location),
                    Text(letterScreenProvider.letter.sentAt),
                    CustomTextWidget(
                        letterChunks: letterScreenProvider.letterChunks,
                        chunkHypotheses: letterScreenProvider.chunkHypotheses),
                  ],
                ),
              ),
            );
          });
        });
  }
}
