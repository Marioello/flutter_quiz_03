import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/games.dart';
import '../../services/database.dart';

class GameJoin extends StatefulWidget {
  const GameJoin({super.key});

  @override
  State<GameJoin> createState() => _GameJoinState();
}

class _GameJoinState extends State<GameJoin> {
  final _formKey = GlobalKey<FormState>();

  //
  Game g = Game(code: '', name: '', status: '', totalQuestion: 0);

  // form values
  String _code = '';
  String _name = '';

  // Declare this variable
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<List<Game>>(context);

    ///
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                validator: (val) {
                  return val!.isEmpty ? 'Silahkan masukan kode kuis' : null;
                },
                onChanged: (val) {
                  setState(() => _code = val.trim());
                },
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
                                .where((element) => element.code == _code)
                                .single;

                            if (g.status == '2') {
                              await DatabaseService(uid: '', code: _code)
                                  .addPlayer(_name);
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
