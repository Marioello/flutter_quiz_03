import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/games.dart';
import '../../models/player.dart';
import '../../models/question.dart';
import '../../services/database.dart';
import '../lobby/wrapper.dart';
import '../question/list.dart';

class GameList extends StatelessWidget {
  const GameList({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Game>>(context);

    ///
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: list.isEmpty
          ? const Center(
              child: Text('Belum ada Kuis'),
            )
          : ListView.builder(
              itemBuilder: (context, i) {
                Game dt = list[i];

                ///
                return MultiProvider(
                  providers: [
                    StreamProvider<List<GameQuestion>>.value(
                      value: DatabaseService(uid: '', code: dt.code)
                          .questionsByCode,
                      initialData: const [],
                    ),
                  ],
                  child: Consumer<List<GameQuestion>>(
                    builder: (_, value, __) {
                      ///
                      return Card(
                        child: ListTile(
                          title: Text('${dt.name} - [${dt.code}]'),
                          subtitle: Row(
                            children: [
                              Text('Total pertanyaan: ${value.length}'),
                              if (value.isNotEmpty)
                                buttonSetQuestions(context, dt),
                            ],
                          ),
                          trailing: value.isNotEmpty
                              ? buttonPlay(context, dt)
                              : buttonSetQuestions(context, dt),
                        ),
                      );
                    },
                    // child: Card(
                    //   child: ListTile(
                    //     title: Text('${dt.code} - ${dt.name}'),
                    //     subtitle: Text(dt.name),
                    //     trailing: dt.status == '1'
                    //         ? buttonSetQuestions(context, dt)
                    //         : buttonPlay(context, dt),
                    //   ),
                    // ),
                  ),
                );
              },
              itemCount: list.length,
            ),
    );
  }

  Widget buttonSetQuestions(BuildContext context, Game dt) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MultiProvider(
                providers: [
                  StreamProvider<List<Question>>.value(
                    value: DatabaseService(uid: '', code: '').questions,
                    initialData: const [],
                  ),
                  StreamProvider<List<GameQuestion>>.value(
                    value: DatabaseService(
                      uid: '',
                      code: dt.code,
                    ).questionsByCode,
                    initialData: const [],
                  ),
                ],
                child: QuestionList(code: dt.code, title: dt.name),
              );
            },
          ),
        ).then((value) => value);
      },
      child: const Text('Set pertanyaan'),
    );
  }

  Widget buttonPlay(BuildContext context, Game dt) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MultiProvider(
                providers: [
                  StreamProvider<List<Game>>.value(
                    value: DatabaseService(uid: '', code: dt.code).games,
                    initialData: const [],
                  ),
                  StreamProvider<List<Player>>.value(
                    value: DatabaseService(uid: '', code: dt.code)
                        .playerListByCode,
                    initialData: const [],
                  ),
                ],
                child: LobbyWrapper(code: dt.code, title: dt.name),
              );
            },
          ),
        );
      },
      child: const Text('Ke lobi'),
    );
  }
}
