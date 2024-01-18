import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
import 'package:pasternak_frontend/widgets/year_range_picker.dart';
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
  bool chunksAvailable = false;
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _initializeIfNeeded();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          _fetchMoreLetters();
        }
      }
    });
  }

  Future<void> _initializeIfNeeded() async {
    final listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);

    if (!listLettersProvider.isInitialized) {
      await ListLettersInitializer().initializeData(context);
      listLettersProvider.setInitialized();
    }
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
    final listLettersProvider = Provider.of<ListLettersProvider>(context);

    if (!listLettersProvider.isInitialized) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Письма Бориса Пастернака'),
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
                  child: Text(_isExpanded ? 'Скрыть фильтры' : 'Показать фильтры'),
                ),
                if (_isExpanded) buildFilterOptions(),
              ],
            ),
            Container(
              height: 3000,
              child: Consumer<ListLettersProvider>(builder: (context, listLettersProvider, child) {
                return Container(
                  height: 3000,
                  child: ListView.builder(
                      itemCount: listLettersProvider.filteredComposites.length,
                      itemBuilder: (context, index) {
                        LetterComposite letterComposite = listLettersProvider.filteredComposites[index];
                        if (index == listLettersProvider.filteredLetters.length - 1) {
                          // Reached the last item, show loading indicator.
                          return const CircularProgressIndicator();
                        }
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 10),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  context.go('/letter/${letterComposite.id}');
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
      ),
    );
  }

  /* List<LetterComposite> filterLetterComposites(
    List<LetterComposite> composites,
    Set<int> selectedCategoryIds,
    Set<int> selectedHypothesisIds,
    String startYear,
    String endYear,
  ) {
    // Filter the composites based on the criteria
    var filteredComposites = composites.where((composite) {
      // Check if any of the composite's category IDs match the selected category IDs
      bool matchesCategories = selectedCategoryIds.isEmpty || composite.categoriesIds.any((id) => selectedCategoryIds.contains(id));

      // Check if any of the keys in the composite's hypothesesCounts match the selected hypothesis IDs
      bool matchesHypotheses =
          selectedHypothesisIds.isEmpty || composite.hypothesesCounts.keys.any((id) => selectedHypothesisIds.contains(id));

      bool matchesYearRange = true;
      if (startYear.isNotEmpty && endYear.isNotEmpty) {
        int compositeYear = int.tryParse(composite.year) ?? 0;
        int startYr = int.tryParse(startYear) ?? 0;
        int endYr = int.tryParse(endYear) ?? 0;
        matchesYearRange = compositeYear >= startYr && compositeYear <= endYr;
      }

      // Return true if the composite matches all criteria
      return matchesCategories && matchesHypotheses && matchesYearRange;
    }).toList();

    // Sort the filtered list by composite.id in ascending order
    filteredComposites.sort((a, b) => a.id.compareTo(b.id));

    return filteredComposites;
  } */

  Widget buildFilterOptions() {
    //final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);
    return Container(
      height: 500,
      child: Consumer<ListLettersProvider>(
        builder: (context, listLettersProvider, child) {
          List<HypothesisInfo> sortedHypotheses = List<HypothesisInfo>.from(listLettersProvider.fetchedHypotheses)
            ..sort((a, b) => b.numOfAppearances.compareTo(a.numOfAppearances));
          return Column(
            children: [
              Container(
                height: 100,
                width: 500,
                child: YearRangePicker(),
              ),
              Container(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Column for Categories
                    Expanded(
                      child: ListView(
                        children: listLettersProvider.fetchedCategories.map((entry) {
                          bool isSelected = listLettersProvider.selectedCategoriesIds.contains(entry.id);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                listLettersProvider.toggleCategoriesSelection(entry.id);
                                listLettersProvider.filterLetterComposites();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: isSelected ? Colors.blue : Colors.grey,
                              ),
                              child: Text(entry.name),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                    // Column for Hypotheses
                    Expanded(
                      child: ListView(
                        children: sortedHypotheses.map((entry) {
                          bool isSelected = listLettersProvider.selectedHypothesesIds.contains(entry.id);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                listLettersProvider.toggleHypothesisSelection(entry.id);
                                listLettersProvider.filterLetterComposites();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: isSelected ? Colors.blue : Colors.grey,
                              ),
                              child: Text('${entry.name} (Встречается ${entry.numOfAppearances} раз)'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
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
