import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:what_what_app/ui/screens/confirm_slot_screen.dart';
import 'package:what_what_app/ui/screens/select_leader_for_slot_screen.dart';
import 'package:what_what_app/ui/helpers/datetime_extension.dart';
import 'package:what_what_app/ui/screens/select_question_for_slot_screen.dart';

class SelectDateForSlotScreen extends StatefulWidget {
  final Slot slot;
  final VoidCallback? initialQuestionsRefreshTrigger;

  SelectDateForSlotScreen({required this.slot, this.initialQuestionsRefreshTrigger});

  @override
  _SelectDateForSlotScreen createState() => _SelectDateForSlotScreen();
}

class _SelectDateForSlotScreen extends State<SelectDateForSlotScreen> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose Slot"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 24),
          child: GenericQuestionList<Slot>(
            getQuestions: client.getAvailableSlots,
            cardFromQuestion: (selectedSlot, triggerRefresh) {
              return WWBasicQuestionCard(
                question: selectedSlot.date?.toFormattedString() ?? "",
                onPressed: () {
                  final slot = widget.slot;
                  slot.id = selectedSlot.id;
                  slot.date = selectedSlot.date;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if (slot.question == null) {
                      return SelectQuestionForSlotScreen(slot: slot);
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
        ));
  }

  void triggerRefresh() {
    setState(() {});
  }
}
