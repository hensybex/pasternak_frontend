import 'package:go_router/go_router.dart';
import '../screens/list_letters/list_letters_screen.dart';

final routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => ListLettersScreen(),
  ),
  // Additional routes will be added here
];
