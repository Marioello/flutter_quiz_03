class Question {
  final String uid;
  final String question;
  final String answer;
  final String opt1;
  final String opt2;
  final String opt3;
  final String opt4;
  late bool isSelected;

  Question({
    required this.uid,
    required this.question,
    required this.answer,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.isSelected,
  });

  List<String> getOptionList() {
    List<String> result = [];

    result.add(opt1);
    result.add(opt2);
    result.add(opt3);
    result.add(opt4);

    return result;
  }
}

class GameQuestion {
  final String uid;
  final String question;
  final String answer;
  final String opt1;
  final String opt2;
  final String opt3;
  final String opt4;

  GameQuestion({
    required this.uid,
    required this.question,
    required this.answer,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
  });
}
