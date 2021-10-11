import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/app_state.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/ui/screens/select_date_for_slot_screen.dart';

class AvailableQuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenericQuestionList<ParentQuestion>(
      cardFromQuestion: (question, triggerRefresh) {
        return WWBasicQuestionCard(
            question: question.text,
            onPressed: () {
              final state = Provider.of<AppState>(context, listen: false);
              final slot = Slot();
              slot.question = question;
              final currentUser = state.currentUser;
              if (currentUser != null) {
                if (currentUser.role == UserRole.leader.asString()) {
                  slot.leader = currentUser;
                }
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SelectDateForSlotScreen(slot: slot);
              }));
            });
      },
      getQuestions: () {
        NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
        return client.getAvailableQuestions();
      },
    );
  }
}
