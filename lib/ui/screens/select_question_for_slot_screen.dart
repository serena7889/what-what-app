import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/back_button.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:what_what_app/ui/screens/confirm_slot_screen.dart';
import 'package:what_what_app/ui/screens/select_date_for_slot_screen.dart';
import 'package:what_what_app/ui/screens/select_leader_for_slot_screen.dart';

class SelectQuestionForSlotScreen extends StatefulWidget {
  final Slot slot;
  final VoidCallback? initialQuestionsRefreshTrigger;

  SelectQuestionForSlotScreen({required this.slot, this.initialQuestionsRefreshTrigger});

  @override
  _SelectQuestionForSlotScreen createState() => _SelectQuestionForSlotScreen();
}

class _SelectQuestionForSlotScreen extends State<SelectQuestionForSlotScreen> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Question"),
        leading: WWBackButton(),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        child: GenericQuestionList<ParentQuestion>(
          getQuestions: client.getAvailableQuestions,
          cardFromQuestion: (question, triggerRefresh) {
            return WWBasicQuestionCard(
              question: question.text,
              onPressed: () {
                widget.slot.question = question;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  final slot = widget.slot;
                  if (slot.date == null) {
                    return SelectDateForSlotScreen(slot: slot);
                  } else if (slot.leader == null) {
                    return SelectLeaderForSlotScreen(slot: slot);
                  } else {
                    return ConfirmSlotScreen(slot: widget.slot);
                  }
                }));
              },
            );
          },
        ),
      ),
    );
  }

  void triggerRefresh() {
    setState(() {});
  }
}
