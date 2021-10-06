import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/buttons/secondary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/question_cards/card_wrapper.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';

class WWAcceptRejectQuestionCard extends StatelessWidget {
  final String questionText;
  final Function() onAcceptPressed;
  final Function() onRejectPressed;

  const WWAcceptRejectQuestionCard({required this.questionText, required this.onAcceptPressed, required this.onRejectPressed});

  Widget build(BuildContext context) {
    return WWCardWrapper(
      onPressed: () => {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
            maxLines: 20,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: WWFonts.fromOptions(context, color: WWColor.primaryText(context)),
          ),
          WWVerticalSpacer(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: WWSecondaryButton(
                  text: "Reject",
                  onPressed: () {
                    onRejectPressed();
                  },
                  backgroundColor: WWColor.secondaryBackground(context),
                ),
              ),
              WWHorizontalSpacer(8),
              Expanded(
                child: WWPrimaryButton(
                  text: "Accept",
                  onPressed: () {
                    onAcceptPressed();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
