import 'package:what_what_app/ui/components/question_cards/leading_trailing_text_with_child_card.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';

class WWScheduledQuestionCard extends StatelessWidget {
  final String question;
  final String date;
  final String answererName;
  final Function() onButtonPressed;

  const WWScheduledQuestionCard({Key? key, required this.question, required this.date, required this.answererName, required this.onButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WWLeadingTrailingTextWithChildCard(
      onCardPressed: onButtonPressed,
      leadingText: date,
      trailingText: answererName,
      child: Text(
        question,
        style: WWFonts.fromOptions(
          context,
          color: WWColor.primaryText(context),
        ),
      ),
    );
  }
}
