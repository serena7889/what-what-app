import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/approve_reject_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnapprovedQuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericQuestionList<ChildQuestion>(
      getQuestions: () {
        NetworkingClient client = Provider.of<NetworkingClient>(context);
        return client.getUnapprovedQuestions();
      },
      cardFromQuestion: (question) {
        return WWAcceptRejectQuestionCard(questionText: question.question, onAcceptPressed: () => {}, onRejectPressed: () => {});
      },
    );
  }
}
