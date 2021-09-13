import 'package:what_what_app/ui/components/buttons/secondary_button.dart';
import 'package:what_what_app/ui/components/question_cards/leading_trailing_text_with_child_card.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class WWChooseQuestionCard extends StatelessWidget {
  final String? leadingText;
  final String? trailingText;
  final Function() onButtonPressed;

  const WWChooseQuestionCard({this.leadingText, this.trailingText, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return WWLeadingTrailingTextWithChildCard(
      onCardPressed: onButtonPressed,
      leadingText: leadingText,
      trailingText: trailingText,
      child: WWSecondaryButton(
        text: "Choose Question",
        onPressed: onButtonPressed,
        backgroundColor: WWColor.secondaryBackground(context),
      ),
    );
  }
}
