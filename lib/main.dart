import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasternak_frontend/main_initializer.dart';
import 'package:pasternak_frontend/models/category_info.dart';
import 'package:pasternak_frontend/models/chunk_hypothesis.dart';
import 'package:pasternak_frontend/models/hypothesis_info.dart';
import 'package:pasternak_frontend/models/letter_chunk.dart';
import 'package:pasternak_frontend/models/letter_composite.dart';
//import 'package:pasternak_frontend/services/version_service.dart';
import 'package:provider/provider.dart';
import 'models/letter.dart';
import 'screens/letter/letter_screen_provider.dart';
import 'screens/list_letters/list_letters_provider.dart';
import 'tools/router.dart';

void main() async {
  // Start with the LoadingScreen
  runApp(MaterialApp(home: LoadingScreen()));

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LetterAdapter());
  Hive.registerAdapter(LetterCompositeAdapter());
  Hive.registerAdapter(CategoryInfoAdapter());
  Hive.registerAdapter(HypothesisInfoAdapter());
  Hive.registerAdapter(LetterChunkAdapter());
  Hive.registerAdapter(ChunkHypothesisAdapter());
  var versionBox = await Hive.openBox('versionBox');
  String localVersion = versionBox.get('version', defaultValue: '0');
  //VersionService versionService = VersionService();
  //String serverVersion = await versionService.fetchServerVersion();
  String serverVersion = "1.0";

  if (localVersion != serverVersion) {
    await initializeData();
    versionBox.put('version', serverVersion);
  }

  // Once data is initialized, switch to MyApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final _router = GoRouter(
    routes: routes,
  );

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListLettersProvider()),
        ChangeNotifierProvider(create: (context) => LetterScreenProvider()),
      ],
      child: MaterialApp.router(
        title: 'Пастернак.GPT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16,
            ),
          ),
        ),
        routeInformationProvider: MyApp._router.routeInformationProvider,
        routeInformationParser: MyApp._router.routeInformationParser,
        routerDelegate: MyApp._router.routerDelegate,
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Идёт загрузка писем и результов исследований...',
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Indeterminate
          ],
        ),
      ),
    );
  }
}
