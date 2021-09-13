import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/questions.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableQuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericQuestionList<ParentQuestion>(
      cardFromQuestion: (question) {
        return WWParentQuestionCard(question: question, onPressed: () => {});
      },
      getQuestions: () {
        NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
        return client.getAvailableQuestions();
      },
    );
  }
}
