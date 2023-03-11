import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services/database.dart';

class AddGame extends StatefulWidget {
  const AddGame({super.key});

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final _formKey = GlobalKey<FormState>();
  int min = 100000; //min and max values act as your 6 digit range
  int max = 999999;
  math.Random rnd = math.Random();

  // form values
  String _code = '';
  String _title = '';

  // Declare this variable
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    refreshCode();
  }

  refreshCode() {
    setState(() => _code = (min + rnd.nextInt(max - min)).toString());
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Text(
                    _code,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () => refreshCode(),
                    icon: const Icon(Icons.cached),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'Nama kuis'),
                validator: (val) {
                  return val!.isEmpty ? 'Silahkan masukan nama kuis' : null;
                },
                onChanged: (val) {
                  setState(() => _title = val);
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
                          // Status = 1 (Created)
                          await DatabaseService(uid: '', code: _code)
                              .modifyGame(_title, '1');
                        }
                      },
                      child: const Text(
                        'Buat',
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
