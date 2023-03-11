import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/question.dart';
import '../../services/database.dart';

class QuestionList extends StatefulWidget {
  final String code;
  final String title;
  const QuestionList({super.key, required this.code, required this.title});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  bool isExist = false;
  List<GameQuestion> lgq = [];
  bool getQuestionStatus(String uid) {
    if (lgq.isNotEmpty) {
      var data = lgq.where((element) => element.uid == uid);
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lq = Provider.of<List<Question>>(context);
    lgq = Provider.of<List<GameQuestion>>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: lq.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      Question q = lq[i];
                      q.isSelected = getQuestionStatus(q.uid);
                      // Question q = Question(
                      //   uid: lq[i].uid,
                      //   question: lq[i].question,
                      //   answer: lq[i].answer,
                      //   opt1: lq[i].opt1,
                      //   opt2: lq[i].opt2,
                      //   opt3: lq[i].opt3,
                      //   opt4: lq[i].opt4,
                      //   isSelected: getQuestionStatus(lq[i].uid),
                      // );
                      // getQuestionStatus(lq[i].uid);
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () async {
                              if (q.isSelected) {
                                await DatabaseService(
                                        uid: q.uid, code: widget.code)
                                    .unselectQuestion();
                              } else {
                                // print('${q.question}: ${q.isSelected}');
                                await DatabaseService(
                                        uid: q.uid, code: widget.code)
                                    .selectQuestion(
                                  q.question,
                                  q.answer,
                                  q.opt1,
                                  q.opt2,
                                  q.opt3,
                                  q.opt4,
                                );
                              }
                            },
                            icon: q.isSelected
                                ? const Icon(
                                    Icons.check_box,
                                    color: Colors.blue,
                                  )
                                : const Icon(Icons.check_box_outline_blank),
                          ),
                          title: Text(q.question),
                        ),
                      );
                    },
                    itemCount: lq.length,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseService(uid: '', code: widget.code)
                        .modifyGame(widget.title, '2')
                        .then((value) => Navigator.of(context).pop(lgq.length));
                  },
                  child: const Text(
                    'Mulai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }
}
