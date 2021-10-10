import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:flutter/material.dart';

typedef void VoidCallback();

class GenericQuestionList<QuestionType> extends StatefulWidget {
  final Widget Function(QuestionType, VoidCallback) cardFromQuestion;
  final Future<List<QuestionType>> Function() getQuestions;
  final bool showLoadingSpinner;

  GenericQuestionList({required this.cardFromQuestion, required this.getQuestions, this.showLoadingSpinner = false});

  @override
  _GenericQuestionListState<QuestionType> createState() => _GenericQuestionListState<QuestionType>();
}

class _GenericQuestionListState<QuestionType> extends State<GenericQuestionList<QuestionType>> {
  Widget questionsList(AsyncSnapshot<List<QuestionType>> snapshot, VoidCallback triggerRefresh) {
    List<QuestionType> list = snapshot.data!;
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: widget.cardFromQuestion(list[i], triggerRefresh),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionType>>(
      future: widget.getQuestions(),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && widget.showLoadingSpinner) return WWLoadingSpinner();
        if (snapshot.hasData) return questionsList(snapshot, triggerRefresh);
        if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
        return Container();
      },
    );
  }

  void triggerRefresh() {
    setState(() {});
    print("SET STATE CALLED");
    return null;
  }
}
