import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:flutter/material.dart';

class GenericQuestionList<QuestionType> extends StatelessWidget {
  final Widget Function(QuestionType) cardFromQuestion;
  final Future<List<QuestionType>> Function() getQuestions;
  final bool showLoadingSpinner;

  GenericQuestionList({required this.cardFromQuestion, required this.getQuestions, this.showLoadingSpinner = false});

  Widget questionsList(AsyncSnapshot<List<QuestionType>> snapshot) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
        children: snapshot.data!.map((question) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: cardFromQuestion(question),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionType>>(
      future: getQuestions(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && showLoadingSpinner) return WWLoadingSpinner();
        if (snapshot.hasData) return questionsList(snapshot);
        if (snapshot.hasData) return Center(child: Text(snapshot.error.toString()));
        return Container();
      },
    );
  }
}
