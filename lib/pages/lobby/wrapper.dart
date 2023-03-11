import 'package:flutter/material.dart';
import 'package:flutter_quiz_03/pages/lobby/list.dart';
import 'package:provider/provider.dart';

import '../../models/games.dart';
import '../../models/player.dart';
import '../../services/database.dart';

class LobbyWrapper extends StatelessWidget {
  final String code;
  final String title;
  const LobbyWrapper({super.key, required this.code, required this.title});

  @override
  Widget build(BuildContext context) {
    final g = Provider.of<List<Game>>(context)
        .where((element) => element.code == code);
    // final p = Provider.of<List<Player>>(context);

    if (g.isNotEmpty) {
      if (g.single.status == "3") {
        return const Center(child: Text('Game started'));
      }
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<Player>>.value(
          value: DatabaseService(uid: '', code: code).playerListByCode,
          initialData: const [],
        ),
      ],
      child: GameLobby(code: code, title: title),
    );
  }
}
