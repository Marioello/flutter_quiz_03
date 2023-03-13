import 'package:flutter/material.dart';
import 'package:flutter_quiz_03/models/player.dart';
import 'package:flutter_quiz_03/services/database.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'config/firebase.dart';
import 'constants.dart';
import 'models/games.dart';
import 'pages/dashboard.dart';
import 'users/player/player.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInit();
  await initializeDateFormatting(localFormat, null).then((_) {
    return runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const Dashboard(),
      home: MultiProvider(
        providers: [
          StreamProvider<List<Game>>.value(
            value: DatabaseService(uid: '', code: '').games,
            initialData: const [],
          ),
          StreamProvider<List<Player2>>.value(
            value: DatabaseService(uid: '', code: '').players2,
            initialData: const [],
          ),
        ],
        child: const PlayerPage(),
      ),
      // home: const AddGame(),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Question>>.value(
      //       value: DatabaseService(uid: '', code: '').questions,
      //       initialData: const [],
      //     ),
      //     StreamProvider<List<GameQuestion>>.value(
      //       value: DatabaseService(uid: '', code: '604401').questionsByCode,
      //       initialData: const [],
      //     ),
      //   ],
      //   child: const QuestionList(code: '604401'),
      // ),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Game>>.value(
      //       value: DatabaseService(uid: '', code: '').games,
      //       initialData: const [],
      //     ),
      //   ],
      //   child: const GameList(),
      // ),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Game>>.value(
      //       value: DatabaseService(uid: '', code: '604401').games,
      //       initialData: const [],
      //     ),
      //   ],
      //   child: const GameJoin(code: '604401'),
      // ),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Player>>.value(
      //       value: DatabaseService(uid: '', code: '604401').playerListByCode,
      //       initialData: const [],
      //     ),
      //   ],
      //   child: const GameLobby(code: '604401', title: 'Create Game 1'),
      // ),
      // home: MultiProvider(
      //   providers: [
      //     StreamProvider<List<Game>>.value(
      //       value: DatabaseService(uid: '', code: '').games,
      //       initialData: const [],
      //     ),
      //   ],
      //   child: const GameWrapper(code: '', title: ''),
      // ),
    );
  }
}
