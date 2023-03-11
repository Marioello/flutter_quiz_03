import 'package:flutter/material.dart';
import 'package:flutter_quiz_03/pages/game/list.dart';
import 'package:provider/provider.dart';

import '../models/games.dart';
import '../models/player.dart';
import '../services/database.dart';
import 'dashboard.dart';
import 'game/add.dart';
import 'lobby/list.dart';

class GameWrapper extends StatefulWidget {
  final String code;
  final String title;
  const GameWrapper({super.key, required this.code, required this.title});

  @override
  State<GameWrapper> createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  @override
  Widget build(BuildContext context) {
    final g = Provider.of<List<Game>>(context)
        .where((element) => element.code == widget.code);
    // final p = Provider.of<List<Player>>(context);

    if (g.isNotEmpty) {
      // switch (g.single.status) {
      //   case '1':
      //     const TextButtonWidget(title: 'Add Quiz', widget: AddGame());
      //     break;
      //   case '2':
      //     const TextButtonWidget(title: 'Add Quiz', widget: AddGame());
      //     break;
      //   default:
      // }
      // if (g.single.status == "4") {
      //   return const Center(child: Text('Game started'));
      // }
      return const Dashboard();
    } else {
      return const Dashboard();
    }

    // return MultiProvider(
    //   providers: [
    //     StreamProvider<List<Player>>.value(
    //       value: DatabaseService(uid: '', code: code).playerListByCode,
    //       initialData: const [],
    //     ),
    //   ],
    //   child: GameLobby(code: code, title: title),
    // );

    // return MultiProvider(
    //   providers: [
    //     StreamProvider<List<Game>>.value(
    //       value: DatabaseService(uid: '', code: code).games,
    //       initialData: const [],
    //     ),
    //   ],
    //   child: const GameList(),
    // );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const TextButtonWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ),
        );
      },
      child: Text(title),
    );
  }
}
