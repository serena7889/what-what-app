import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/back_button.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/text_field.dart';
import 'package:what_what_app/ui/routes.dart';

class ConfirmParentScreen extends StatefulWidget {
  final ParentQuestion? parentToAddTo;
  final ChildQuestion childQuestion;
  final TextEditingController controller = TextEditingController();
  final VoidCallback pendingListRefreshTrigger;

  ConfirmParentScreen({this.parentToAddTo, required this.childQuestion, required this.pendingListRefreshTrigger}) {
    if (parentToAddTo != null) {
      controller.text = parentToAddTo!.text;
    } else {
      controller.text = childQuestion.question;
    }
  }

  @override
  _ConfirmParentScreenState createState() => _ConfirmParentScreenState();
}

class _ConfirmParentScreenState extends State<ConfirmParentScreen> {
  // final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonText = widget.parentToAddTo == null ? 'Create' : 'Add';
    return Scaffold(
      appBar: AppBar(leading: WWBackButton()),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Spacer(),
            WWTextField(placeholder: 'Question', controller: widget.controller),
            WWVerticalSpacer(16),
            WWPrimaryButton(text: buttonText, onPressed: () => widget.parentToAddTo == null ? createNewParent(context) : addToParent(context)),
            Spacer()
          ])),
    );
  }

  void createNewParent(context) async {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    ParentQuestion? createdQuestion = await client.createNewParentQuestion(widget.controller.text, [widget.childQuestion.id]);
    showCompletionPopups(createdQuestion != null);
  }

  void addToParent(context) async {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    ParentQuestion? addedToQuestion = await client.addChildToParentQuestion(
      updatedQuestionText: widget.controller.text,
      parentId: widget.parentToAddTo!.id,
      childId: widget.childQuestion.id,
    );
    showCompletionPopups(addedToQuestion != null);
  }

  void showCompletionPopups(bool success) {
    widget.pendingListRefreshTrigger();
    if (success) {
      // TODO: Set up custom success alert
      AlertDialog successAlert = AlertDialog(
        title: Text("Success!"),
        actions: [TextButton(onPressed: goBackToQuestionScreen, child: Text('Go Back'))],
      );
      showDialog(context: context, builder: (context) => successAlert);
    } else {
      // TODO: Set up custom error alert
      AlertDialog errorAlert = AlertDialog(
        title: Text("Error!"),
        actions: [TextButton(onPressed: goBackToQuestionScreen, child: Text('Go Back'))],
      );
      showDialog(context: context, builder: (context) => errorAlert);
    }
  }

  void goBackToQuestionScreen() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.questionTogglerScreenRoute));
  }
}
