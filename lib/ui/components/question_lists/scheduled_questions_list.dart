import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/helpers/datetime_extension.dart';
import 'package:what_what_app/ui/components/question_cards/choose_question_card.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/ui/screens/select_question_for_slot_screen.dart';

class ScheduledQuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
    return GenericQuestionList<Slot>(
      getQuestions: () {
        return client.getScheduledQuestionsList();
      },
      cardFromQuestion: (slot, triggerRefresh) {
        if (slot.question != null && slot.leader != null) {
          return WWScheduledQuestionCard(
            question: slot.question!.text,
            date: slot.date?.toFormattedString() ?? "",
            answererName: slot.leader!.name,
            onButtonPressed: () => {},
          );
        } else {
          return WWChooseQuestionCard(
            leadingText: slot.date?.toFormattedString() ?? "",
            onButtonPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                final currentUser = client.appState.currentUser;
                if (currentUser != null) {
                  if (currentUser.role == UserRole.leader.asString()) {
                    slot.leader = currentUser;
                  }
                }
                return SelectQuestionForSlotScreen(slot: slot);
              })),
            },
          );
        }
      },
    );
  }
}
