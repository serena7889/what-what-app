import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/nav_drawer.dart';
import 'package:what_what_app/ui/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWAskQuestionScreen extends StatelessWidget {
  static const String pageRoute = "/ask_question_screen";

  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ask Question")),
      drawer: WWNavDrawer(),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Column(
            children: [
              WWTextField(placeholder: "What what...", controller: textFieldController),
              WWVerticalSpacer(20),
              WWPrimaryButton(text: "Submit", onPressed: () => submitPressed(context)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitPressed(BuildContext context) async {
    String question = textFieldController.text;
    NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);

    if (await client.appState.getToken() == null) {
      final passphraseController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Title"),
            content: WWTextField(controller: passphraseController, placeholder: "Passphrase", style: WWTextFieldStyle.singleLine),
            actions: [
              TextButton(
                onPressed: () async {
                  final correct = await client.checkAskQuestionPassphrase(passphraseController.text);
                  Navigator.pop(context);
                  if (correct) await addQuestion(context, question);
                },
                child: Text("Check"),
              ),
            ],
          );
        },
      );
    } else {
      await addQuestion(context, question);
    }
  }

  Future<void> addQuestion(BuildContext context, String question) async {
    NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
    bool success = await client.addQuestion(question);
    textFieldController.text = "";
    if (success) {
      // TODO: Set up custom success alert
      AlertDialog successAlert = AlertDialog(
        title: Text("Success!"),
        content: Text("Your question has been added and we'll get to it as soon as possible."),
      );
      showDialog(context: context, builder: (context) => successAlert);
    } else {
      // TODO: Set up custom error alert
      AlertDialog errorAlert = AlertDialog(
        title: Text("Error..."),
        content: Text("There was a problem adding your question. Please try again later."),
      );
      showDialog(context: context, builder: (context) => errorAlert);
    }
  }
}
