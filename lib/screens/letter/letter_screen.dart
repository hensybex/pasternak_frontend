import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasternak_frontend/screens/letter/letter_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../models/hypothesis_info.dart';
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
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _initFuture = LetterScreenInitializer().initializeData(context, widget.letterId);
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
          return Consumer<LetterScreenProvider>(builder: (context, letterScreenProvider, child) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      context.pop();
                    } else {
                      // Handle the case when there's no previous page; maybe navigate to a default route
                      context.go('/');
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(
                  letterScreenProvider.letter.sentTo,
                  style: const TextStyle(fontFamily: 'Open Sans'),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (letterScreenProvider.hypothesesInfo.isNotEmpty)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? 'Скрыть фильтры' : 'Показать фильтры',
                          style: const TextStyle(fontFamily: 'Open Sans'),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      letterScreenProvider.letter.location,
                      style: const TextStyle(fontFamily: 'Open Sans'),
                    ),
                    Text(
                      letterScreenProvider.letter.sentAt,
                      style: const TextStyle(fontFamily: 'Open Sans'),
                    ),
                    if (_isExpanded) buildFilterOptions(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomTextWidget(
                          letterChunks: letterScreenProvider.letterChunks, chunkHypotheses: letterScreenProvider.chunkHypotheses),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Заметки:',
                      style: TextStyle(fontFamily: 'Merriweather'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SelectableText(
                        letterScreenProvider.letter.letterNotes,
                        style: const TextStyle(fontFamily: 'Merriweather'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget buildFilterOptions() {
    return Container(
      height: 400,
      child: Consumer<LetterScreenProvider>(
        builder: (context, letterScreenProvider, child) {
          List<HypothesisInfo> sortedHypotheses = List<HypothesisInfo>.from(letterScreenProvider.hypothesesInfo);
          return ListView(
            children: sortedHypotheses.map((entry) {
              bool isSelected = letterScreenProvider.selectedHypotheses.contains(entry.id);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    letterScreenProvider.toggleHypothesisSelection(entry.id);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isSelected ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    entry.name,
                    style: const TextStyle(fontFamily: 'Open Sans'),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
