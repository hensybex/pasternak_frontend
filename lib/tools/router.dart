import 'package:go_router/go_router.dart';
import '../screens/letter/letter_screen.dart';
import '../screens/list_letters/list_letters_screen.dart';

final routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => ListLettersScreen(),
    routes: [
      // Nested routes
      GoRoute(
        path: 'letter/:letter_id', // Note the relative path
        builder: (context, state) {
          int letterId = int.parse(state.pathParameters['letter_id']!);
          return LetterScreen(
            letterId: letterId,
          );
        },
      ),
    ],
  ),
  // Additional routes will be added here
];
