import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasternak_frontend/models/letter.dart';
import 'package:provider/provider.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../services/letters_service.dart';
import '../../widgets/letter_list_card.dart';
import 'init.dart';
import 'list_letters_provider.dart';

class ListLettersScreen extends StatefulWidget {
  const ListLettersScreen({super.key});

  @override
  State<ListLettersScreen> createState() => _ListLettersScreenState();
}

class _ListLettersScreenState extends State<ListLettersScreen> {
  late Future<void> _initFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initFuture = ListLettersInitializer().initializeData(context);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          _fetchMoreLetters();
        }
      }
    });
  }

  void _fetchMoreLetters() async {
    int pageSize = 20;
    final listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);
    if (listLettersProvider.isLoading) {
      return;
    }

    final letters = await LettersService().fetchLetters(
      listLettersProvider.pageIndex,
      pageSize,
    );

    if (letters.isNotEmpty) {
      listLettersProvider.appendFilteredLetters(letters);
      listLettersProvider.incrementPageIndex();
    } else {
      // No more letters to load.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Letters'),
      ),
      body: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<ListLettersProvider>(builder: (context, listLettersProvider, child) {
              return WebSmoothScroll(
                controller: _scrollController,
                scrollOffset: 100,
                animationDuration: 1,
                curve: Curves.easeInOutCirc,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: List.generate(listLettersProvider.filteredLetters.length, (index) {
                      Letter letter = listLettersProvider.filteredLetters[index];
                      if (index == listLettersProvider.filteredLetters.length - 1) {
                        // Reached the last item, show loading indicator.
                        return const CircularProgressIndicator();
                      }
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 10),
                          child:  MouseRegion(
                        cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                            onTap: () {
                              context.go('/letter/${letter.id}', extra: letter);
                            },
                              child: LetterListCard(
                                letter: letter,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            });
          }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
