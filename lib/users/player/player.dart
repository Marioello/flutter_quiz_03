import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/games.dart';
import '../../models/player.dart';
import '../../pages/lobby/list.dart';
import '../../services/database.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final _formKey = GlobalKey<FormState>();

  ///
  // Game g = Game(code: '', name: '', status: '', totalQuestion: 0);

  String _quizCode = '';
  String _name = '';

  ///
  bool _isExists = false;

  @override
  Widget build(BuildContext context) {
    final gList = Provider.of<List<Game>>(context);
    final pList = Provider.of<List<Player2>>(context);
    // final db = DatabaseService(uid: '', code: _quizCode);

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
                children: [
                  textHelper(playerHeaderText, size: 30.0, isBold: true),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'Kode'),
                validator: (val) {
                  /// if code epmty
                  if (val!.isEmpty) {
                    return playerValCodeEmpty;
                  }

                  /// min & max length
                  if (val.length < 6 || val.length > 6) {
                    return playerValCodeLength;
                  }

                  /// if not exists
                  var g = gList.where((fw) => fw.code == _quizCode).toList();

                  if (g.isEmpty) {
                    return playerValCodeNotExists;
                  }

                  return null;
                },
                onChanged: (val) => setState(() => _quizCode = val.trim()),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'Nama'),
                validator: (val) {
                  /// if code not input first
                  if (_quizCode.isEmpty) {
                    return playerValCodeEmpty;
                  }

                  /// if exists
                  var pl = pList.where((fw) => fw.code == _quizCode).toList();

                  if (pl.isNotEmpty) {
                    int p = pl
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(_name.toLowerCase()))
                        .length;

                    if (p > 0) {
                      return playerValNameExists;
                    }
                  }

                  /// if empty
                  if (val!.isEmpty) {
                    return playerValNameEmpty;
                  }

                  /// min length
                  if (val.length < 3) {
                    return playerValNameLengthLT;
                  }

                  /// max length
                  if (val.length > 20) {
                    return playerValNameLengthGT;
                  }

                  return null;
                },
                onChanged: (val) => setState(() => _name = val),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: '', code: _quizCode)
                              .addPlayer2(_name)
                              .then(
                                (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return GameLobby(
                                        code: _quizCode,
                                        title: '',
                                      );
                                    },
                                  ),
                                  (route) => false,
                                ),
                              );
                        }
                      },
                      child: textHelper(playerButtonText, color: Colors.white),
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
