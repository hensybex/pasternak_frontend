import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../services/letters_service.dart';
import '../../widgets/letter_list_card.dart';
import 'init.dart';
import 'list_letters_provider.dart';

class ListLettersScreen extends StatefulWidget {
  @override
  _ListLettersScreenState createState() => _ListLettersScreenState();
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
          // User is at the top of the list.
        } else {
          // User has reached the end of the list.
          _fetchMoreLetters();
        }
      }
    });
  }

  void _fetchMoreLetters() async {
    int pageSize = 20;
    final listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);
    if (listLettersProvider.isLoading) {
      // Avoid making multiple simultaneous requests.
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
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<ListLettersProvider>(builder: (context, listLettersProvider, child) {
              return WebSmoothScroll(
                controller: _scrollController, // Use the same scroll controller
                scrollOffset: 100,
                animationDuration: 1,
                curve: Curves.easeInOutCirc,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: List.generate(listLettersProvider.filteredLetters.length, (index) {
                      if (index == listLettersProvider.filteredLetters.length - 1) {
                        // Reached the last item, show loading indicator.
                        return CircularProgressIndicator();
                      }
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 10),
                          child: LetterListCard(
                            letter: listLettersProvider.filteredLetters[index],
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


/* // Replace with your method to fetch letters
Future<List<Letter>> fetchLetters(int pageKey, int pageSize) async {
  var box = await Hive.openBox<Letter>('letters');

  // Check if letters are cached
  if (box.isNotEmpty) {
    return box.values.toList();
  }

  final LettersService lettersService = LettersService();
  List<Letter> letters = await lettersService.fetchLetters(pageKey, pageSize);

  for (var letter in letters) {
    box.put(letter.id, letter);
  }

  return letters;
} */
/* Future<void> _fetchPage(int pageKey) async {
    try {
      // Replace with your method to fetch letters
      final newLetters = await fetchLetters(pageKey, _pageSize);
      final isLastPage = newLetters.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newLetters);
      } else {
        final nextPageKey = pageKey + newLetters.length;
        _pagingController.appendPage(newLetters, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  } */