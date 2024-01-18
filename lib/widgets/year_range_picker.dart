import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/list_letters/list_letters_provider.dart';

class YearRangePicker extends StatefulWidget {
  @override
  _YearRangePickerState createState() => _YearRangePickerState();
}

class _YearRangePickerState extends State<YearRangePicker> {
  RangeValues _currentRange = RangeValues(1905, 1960);

  @override
  Widget build(BuildContext context) {
    final ListLettersProvider listLettersProvider = Provider.of<ListLettersProvider>(context, listen: false);

    return Column(
      children: [
        RangeSlider(
          values: _currentRange,
          min: 1905,
          max: 1960,
          divisions: 55, // for each year between 1905 and 1960
          labels: RangeLabels('${_currentRange.start.round()}', '${_currentRange.end.round()}'),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRange = values;
              // Ensuring the end year is never before the start year
              if (_currentRange.end < _currentRange.start) {
                _currentRange = RangeValues(_currentRange.start, _currentRange.start);
              }
            });
            listLettersProvider.startYear = _currentRange.start.round().toString();
            listLettersProvider.endYear = _currentRange.end.round().toString();
            listLettersProvider.filterLetterComposites();
          },
        ),
        Text('Start Year: ${_currentRange.start.round()}'),
        Text('End Year: ${_currentRange.end.round()}'),
      ],
    );
  }
}
