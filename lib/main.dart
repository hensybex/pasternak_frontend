import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/letter.dart';
import 'screens/list_letters/list_letters_provider.dart';
import 'tools/router.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LetterAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final _router = GoRouter(
    routes: routes,
    /* errorBuilder: (context, state) {
      return NotFoundScreen(
        errorMessage: state.error.toString(),
      );
    }, */
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListLettersProvider()),
      ],
      child: MaterialApp.router(
        title: 'Research App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationProvider: MyApp._router.routeInformationProvider,
        routeInformationParser: MyApp._router.routeInformationParser,
        routerDelegate: MyApp._router.routerDelegate,
      ),
    );
  }
}
