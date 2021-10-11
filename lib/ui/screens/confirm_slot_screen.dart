import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:what_what_app/ui/helpers/datetime_extension.dart';

class ConfirmSlotScreen extends StatefulWidget {
  final Slot slot;
  final VoidCallback? initialQuestionsRefreshTrigger;

  const ConfirmSlotScreen({Key? key, required this.slot, this.initialQuestionsRefreshTrigger}) : super(key: key);

  @override
  _ConfirmSlotScreenState createState() => _ConfirmSlotScreenState();
}

class _ConfirmSlotScreenState extends State<ConfirmSlotScreen> {
  WWPrimaryButtonState confirmButtonState = WWPrimaryButtonState.active;

  @override
  Widget build(BuildContext context) {
    final slot = widget.slot;
    final leader = slot.leader;
    final question = slot.question;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, bottom: 32),
        child: Center(
          child: ((leader == null || question == null || slot.id == null || slot.date == null))
              ? Text("Leader or question not selected", style: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 20))
              : Column(mainAxisSize: MainAxisSize.min, children: [
                  WWScheduledQuestionCard(question: question.text, date: slot.date!.toFormattedString(), answererName: leader.name, onButtonPressed: () {}),
                  WWVerticalSpacer(32),
                  WWPrimaryButton(text: "Confirm", state: confirmButtonState, onPressed: () => confirmPressed(context, leaderId: leader.id, questionId: question.id, slotId: slot.id!))
                ]),
        ),
      ),
    );
  }

  void confirmPressed(context, {required String leaderId, required String questionId, required String slotId}) async {
    confirmButtonState = WWPrimaryButtonState.loading;
    final client = Provider.of<NetworkingClient>(context, listen: false);
    final result = await client.assignQuestionAndLeaderToSlot(slotId, questionId, leaderId);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(result ? "Success" : "Error"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName(Routes.questionTogglerScreenRoute));
                if (widget.initialQuestionsRefreshTrigger != null) widget.initialQuestionsRefreshTrigger!();
              },
              child: Text("Go back"),
            ),
          ],
        );
      },
    );
  }
}
