import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/games.dart';
import '../services/database.dart';
import 'game/add.dart';
import 'game/join.dart';
import 'game/list.dart';
import 'wrapper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButtonWidget(
              title: 'Quiz List',
              widget: MultiProvider(
                providers: [
                  StreamProvider<List<Game>>.value(
                    value: DatabaseService(uid: '', code: '').games,
                    initialData: const [],
                  ),
                ],
                child: const GameList(),
              ),
            ),
            const TextButtonWidget(title: 'Add Quiz', widget: AddGame()),
            TextButtonWidget(
              title: 'Join Quiz',
              widget: MultiProvider(
                providers: [
                  StreamProvider<List<Game>>.value(
                    value: DatabaseService(uid: '', code: '').games,
                    initialData: const [],
                  ),
                ],
                child: const GameJoin(),
              ),
            ),
            // TextButtonWidget(
            //   title: 'Quiz Lobby',
            //   widget: MultiProvider(
            //     providers: [
            //       StreamProvider<List<Game>>.value(
            //         value: DatabaseService(uid: '', code: '604401').games,
            //         initialData: const [],
            //       ),
            //       StreamProvider<List<Player>>.value(
            //         value: DatabaseService(uid: '', code: '604401')
            //             .playerListByCode,
            //         initialData: const [],
            //       ),
            //     ],
            //     child: const LobbyWrapper(
            //       code: '604401',
            //       title: 'Create Game 1',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
