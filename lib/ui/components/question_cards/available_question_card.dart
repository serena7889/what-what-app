import 'package:what_what_app/ui/components/question_cards/card_wrapper.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';

class WWBasicQuestionCard extends StatelessWidget {
  final String question;
  final Function()? onPressed;

  const WWBasicQuestionCard({required this.question, required this.onPressed});

  Widget build(BuildContext context) {
    final questionText = Expanded(
      child: Text(
        question,
        maxLines: 20,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: WWFonts.fromOptions(context, color: WWColor.primaryText(context)),
      ),
    );

    return WWCardWrapper(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: onPressed == null
            ? [questionText]
            : [
                questionText,
                SizedBox(width: 12),
                Icon(Icons.chevron_right_sharp),
              ],
      ),
    );
  }
}
