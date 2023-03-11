import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quiz_03/models/games.dart';
import 'package:flutter_quiz_03/models/player.dart';

import '../models/question.dart';

class DatabaseService {
  final String uid;
  final String code;

  DatabaseService({required this.uid, required this.code});

  final CollectionReference gamesColl =
      FirebaseFirestore.instance.collection('games');
  final CollectionReference questionsColl =
      FirebaseFirestore.instance.collection('questions');

  // add Quiz
  Future modifyGame(String name, String status) async {
    return await gamesColl.doc(code).set({
      'name': name,
      'status': status,
    });
  }

  // Get Game List
  List<Game> _gameList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Game(
              code: e.id,
              name: e.get('name').toString(),
              status: e.get('status').toString(),
              totalQuestion: 0,
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Stream<List<Game>> get games => gamesColl.snapshots().map(_gameList);

  // Quiz list from snapshot
  List<Question> _questionList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Question(
              uid: e.id,
              question: e.get('question').toString(),
              answer: e.get('answer').toString(),
              opt1: e.get('opt1').toString(),
              opt2: e.get('opt2').toString(),
              opt3: e.get('opt3').toString(),
              opt4: e.get('opt4').toString(),
              isSelected: false,
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Stream<List<Question>> get questions =>
      questionsColl.snapshots().map(_questionList);

  // Quiz list from snapshot
  List<GameQuestion> _gameQuestionList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => GameQuestion(
              uid: e.id,
              question: e.get('question').toString(),
              answer: e.get('answer').toString(),
              opt1: e.get('opt1').toString(),
              opt2: e.get('opt2').toString(),
              opt3: e.get('opt3').toString(),
              opt4: e.get('opt4').toString(),
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  // Question list by uid
  Stream<List<GameQuestion>> get questionsByCode => FirebaseFirestore.instance
      .collection('games/$code/questions')
      .snapshots()
      .map(_gameQuestionList);

  // Add / Edit Question
  Future selectQuestion(String question, String answer, String opt1,
      String opt2, String opt3, String opt4) async {
    print('uid: $code');
    print('id: $uid');
    return await FirebaseFirestore.instance
        .collection('games/$code/questions')
        .doc(uid)
        .set({
      'question': question,
      'answer': answer,
      'opt1': opt1,
      'opt2': opt2,
      'opt3': opt3,
      'opt4': opt4,
    });
  }

  // Delete Question
  Future unselectQuestion() async {
    return await FirebaseFirestore.instance
        .collection('games/$code/questions')
        .doc(uid)
        .delete();
  }

  // Add Player
  Future addPlayer(String name) async {
    return await FirebaseFirestore.instance
        .collection('games/$code/players')
        .doc()
        .set({
      'name': name,
    });
  }

  // Delete Player
  Future deletePlayer() async {
    return await FirebaseFirestore.instance
        .collection('games/$code/players')
        .doc(uid)
        .delete();
  }

  // Player list from snapshot
  List<Player> _playerList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs
          .map(
            (e) => Player(
              uid: e.id,
              name: e.get('name').toString(),
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  // Question list by uid
  Stream<List<Player>> get playerListByCode => FirebaseFirestore.instance
      .collection('games/$code/players')
      .snapshots()
      .map(_playerList);
}
