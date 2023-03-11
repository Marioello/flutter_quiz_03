import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.dart';
import '../../services/database.dart';

class GameLobby extends StatelessWidget {
  final String code;
  final String title;
  const GameLobby({super.key, required this.code, required this.title});

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<List<Player>>(context);

    ///
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${p.length}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(Icons.people),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Consumer<List<Player>>(
                builder: (_, value, __) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: value.length,
                    itemBuilder: (_, i) {
                      /// Set value to model
                      Player dt = value[i];

                      ///
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dt.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await DatabaseService(uid: dt.uid, code: code)
                                      .deletePlayer();
                                },
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Expanded(
            //   child: Consumer<List<Player>>(
            //     builder: (_, value, __) {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             child: ListTile(
            //               title: Text(value[index].name),
            //               trailing: TextButton(
            //                 onPressed: () async {
            //                   await DatabaseService(
            //                           uid: value[index].uid, code: code)
            //                       .deletePlayer();
            //                 },
            //                 child: const Text('Keluar'),
            //               ),
            //             ),
            //           );
            //         },
            //         itemCount: p.length,
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await DatabaseService(uid: '', code: code)
                    .modifyGame(title, '3');
              },
              child: const Text(
                'Mulai',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
