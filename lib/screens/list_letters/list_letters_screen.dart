import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
import 'package:provider/provider.dart';
import '../../models/hypothesis_info.dart';
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
  bool chunksAvailable = false;
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;

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
    final listLettersProvider =
        Provider.of<ListLettersProvider>(context, listen: false);
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
    return FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text('List of Letters'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                              _isExpanded ? 'Hide Filters' : 'Show Filters'),
                        ),
                        if (_isExpanded) buildFilterOptions(),
                      ],
                    ),
                    Container(
                      height: 3000,
                      child: Consumer<ListLettersProvider>(
                          builder: (context, listLettersProvider, child) {
                        List<LetterComposite> allComposites =
                            listLettersProvider.letterComposites;
                        List<LetterComposite> filteredComposites =
                            filterLetterComposites(
                                allComposites,
                                listLettersProvider.selectedCategories,
                                listLettersProvider.selectedHypotheses);
                        return Container(
                          height: 3000,
                          child: ListView.builder(
                              itemCount: filteredComposites.length,
                              itemBuilder: (context, index) {
                                LetterComposite letterComposite =
                                    filteredComposites[index];
                                if (index ==
                                    listLettersProvider.filteredLetters.length -
                                        1) {
                                  // Reached the last item, show loading indicator.
                                  return const CircularProgressIndicator();
                                }
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        right: 16,
                                        bottom: 16,
                                        left: 10),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.go(
                                              '/letter/${letterComposite.id}');
                                        },
                                        child: LetterListCard(
                                          letterComposite: letterComposite,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                    ),
                  ],
                ),
              ));
        });
  }

  List<LetterComposite> filterLetterComposites(List<LetterComposite> composites,
      Set<int> selectedCategoryIds, Set<int> selectedHypothesisIds) {
    return composites.where((composite) {
      // Check if any of the composite's category IDs match the selected category IDs
      bool matchesCategories = selectedCategoryIds.isEmpty ||
          composite.categoriesIds.any((id) => selectedCategoryIds.contains(id));

      // Check if any of the keys in the composite's hypothesesCounts match the selected hypothesis IDs
      bool matchesHypotheses = selectedHypothesisIds.isEmpty ||
          composite.hypothesesCounts.keys
              .any((id) => selectedHypothesisIds.contains(id));

      // Return true if the composite matches both categories and hypotheses criteria
      return matchesCategories && matchesHypotheses;
    }).toList();
  }

  Widget buildFilterOptions() {
    return Container(
      height: 400,
      child: Consumer<ListLettersProvider>(
        builder: (context, listLettersProvider, child) {
          List<HypothesisInfo> sortedHypotheses = List<HypothesisInfo>.from(
              listLettersProvider.fetchedHypotheses)
            ..sort((a, b) => b.numOfAppearances.compareTo(a.numOfAppearances));
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Column for Categories
              Expanded(
                child: ListView(
                  children: listLettersProvider.fetchedCategories.map((entry) {
                    bool isSelected = listLettersProvider.selectedCategories
                        .contains(entry.id);
                    return ElevatedButton(
                      onPressed: () {
                        listLettersProvider.toggleCategoriesSelection(entry.id);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isSelected ? Colors.blue : Colors.grey,
                      ),
                      child: Text(entry.name),
                    );
                  }).toList(),
                ),
              ),
              // Column for Hypotheses
              Expanded(
                child: ListView(
                  children: sortedHypotheses.map((entry) {
                    bool isSelected = listLettersProvider.selectedHypotheses
                        .contains(entry.id);
                    return ElevatedButton(
                      onPressed: () {
                        listLettersProvider.toggleHypothesisSelection(entry.id);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isSelected ? Colors.blue : Colors.grey,
                      ),
                      child: Text(
                          '${entry.name} (Встречается ${entry.numOfAppearances} раз)'),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
