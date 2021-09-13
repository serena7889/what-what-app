import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/ui/components/question_cards/card_wrapper.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';

class WWParentQuestionCard extends StatelessWidget {
  final ParentQuestion question;
  final Function() onPressed;

  const WWParentQuestionCard({required this.question, required this.onPressed});

  Widget build(BuildContext context) {
    return WWCardWrapper(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              question.text,
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: WWFonts.fromOptions(context, color: WWColor.primaryText(context)),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Icon(Icons.chevron_right_sharp),
        ],
      ),
    );
  }
}
