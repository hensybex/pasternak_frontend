import 'package:go_router/go_router.dart';
import '../models/letter.dart';
import '../screens/letter/letter_screen.dart';
import '../screens/list_letters/list_letters_screen.dart';

final routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => ListLettersScreen(),
  ),
  GoRoute(
  path: '/letter/:letter_id',
  builder: (context, state) {
    // Assuming 'Letter' is your data model class
    final Letter letter = state.extra as Letter;
    return LetterScreen(letter: letter);
  },
),
  // Additional routes will be added here
];