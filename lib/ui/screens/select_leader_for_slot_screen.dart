import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:what_what_app/ui/screens/confirm_slot_screen.dart';
import 'package:what_what_app/ui/screens/select_date_for_slot_screen.dart';
import 'package:what_what_app/ui/screens/select_question_for_slot_screen.dart';

class SelectLeaderForSlotScreen extends StatefulWidget {
  final Slot slot;
  final VoidCallback? initialQuestionsRefreshTrigger;

  SelectLeaderForSlotScreen({required this.slot, this.initialQuestionsRefreshTrigger});

  @override
  _SelectLeaderForSlotScreenState createState() => _SelectLeaderForSlotScreenState();
}

class _SelectLeaderForSlotScreenState extends State<SelectLeaderForSlotScreen> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose Leader"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 24),
          child: GenericQuestionList<User>(
              getQuestions: () => client.getUsers(roles: [UserRole.admin, UserRole.leader]),
              cardFromQuestion: (leader, triggerRefresh) {
                return WWBasicQuestionCard(question: leader.name, onPressed: () => selectUser(context, leader));
              }),
        ));
  }

  void selectUser(context, User leader) {
    widget.slot.leader = leader;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final slot = widget.slot;
      if (slot.date == null) {
        return SelectDateForSlotScreen(slot: slot);
      } else if (slot.question == null) {
        return SelectQuestionForSlotScreen(slot: slot);
      } else {
        return ConfirmSlotScreen(slot: widget.slot);
      }
    }));
  }

  void triggerRefresh() {
    setState(() {});
  }
}
