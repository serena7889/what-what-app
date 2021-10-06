import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnsweredQuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericQuestionList<Slot>(
      cardFromQuestion: (slot, triggerRefresh) {
        return WWScheduledQuestionCard(
          question: slot.question?.text ?? "",
          date: slot.date.toString(),
          answererName: slot.leader?.name ?? "",
          onButtonPressed: () => {},
        );
      },
      getQuestions: () {
        NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
        return client.getAnsweredQuestions();
      },
    );
  }
}
