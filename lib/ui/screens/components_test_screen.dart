import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/buttons/secondary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/question_cards/approve_reject_question_card.dart';
import 'package:what_what_app/ui/components/question_cards/available_question_card.dart';
import 'package:what_what_app/ui/components/question_cards/choose_question_card.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

String fakeQuestionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend purus id dolor ornare, in eleifend eros vehicula.";

class ComponentsTestScreen extends StatelessWidget {
  late final question = ParentQuestion(id: '123', scheduled: true, text: fakeQuestionText, children: [], topics: []);

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          color: WWColor.primaryBackground(context),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WWPrimaryButton(text: "Primary Button", onPressed: () => {}),
                WWVerticalSpacer(8),
                WWSecondaryButton(
                  text: "Toggle",
                  onPressed: () => theme.toggleMode(),
                  backgroundColor: WWColor.primaryBackground(context),
                ),
                WWVerticalSpacer(8),
                WWBasicQuestionCard(
                  question: question.text,
                  onPressed: () => {},
                ),
                WWVerticalSpacer(8),
                WWChooseQuestionCard(
                  onButtonPressed: () => {},
                  leadingText: "17 Sep 21",
                ),
                WWVerticalSpacer(8),
                WWScheduledQuestionCard(
                  question: fakeQuestionText,
                  date: "17 Sep 21",
                  answererName: "Amy Walker",
                  onButtonPressed: () => {},
                ),
                WWVerticalSpacer(8),
                WWAcceptRejectQuestionCard(
                  questionText: fakeQuestionText,
                  onAcceptPressed: () => {},
                  onRejectPressed: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
