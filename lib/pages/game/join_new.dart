import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/games.dart';
import '../../models/player.dart';
import '../../services/database.dart';
import '../lobby/list.dart';

class JoinNew extends StatefulWidget {
  const JoinNew({super.key});

  @override
  State<JoinNew> createState() => _JoinNewState();
}

class _JoinNewState extends State<JoinNew> {
  final _formKey = GlobalKey<FormState>();

  ///
  Game g = Game(code: '', name: '', status: '', totalQuestion: 0);

  String _quizCode = '';
  String _name = '';
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Game>>(context);
    final db = DatabaseService(uid: '', code: _quizCode);

    ///
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Masukan kode kuis untuk bergabung',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'Kode'),
                validator: (val) =>
                    val!.isEmpty ? 'Silahkan masukan kode kuis' : null,
                onChanged: (val) => setState(() => _quizCode = val.trim()),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'Nama'),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Silahkan masukan nama anda';
                  } else if (val.length > 10) {
                    return 'Nama hanya 10 karakter';
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() => _name = val);
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (list.isNotEmpty) {
                            g = list
                                .where((element) => element.code == _quizCode)
                                .single;

                            if (g.status == '2') {
                              db.addPlayer(_name).then(
                                (value) {
                                  return Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return MultiProvider(
                                        providers: [
                                          StreamProvider<List<Player>>.value(
                                            value: DatabaseService(
                                              uid: '',
                                              code: _quizCode,
                                            ).playerListByCode,
                                            initialData: const [],
                                          ),
                                        ],
                                        child: GameLobby(
                                            code: _quizCode, title: g.name),
                                      );
                                    },
                                  ), (route) => false);
                                },
                              );
                            } else {
                              // Can't join game are clossd
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Masuk',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
