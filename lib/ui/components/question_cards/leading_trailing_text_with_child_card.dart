import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/question_cards/card_wrapper.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';

class WWLeadingTrailingTextWithChildCard extends StatelessWidget {
  final String? leadingText;
  final String? trailingText;
  final Function() onCardPressed;
  final Widget child;

  TextStyle headingStyle(context) {
    return WWFonts.fromOptions(
      context,
      weight: WWFontWeight.semibold,
      color: WWColor.secondaryText(context),
    );
  }

  const WWLeadingTrailingTextWithChildCard({this.leadingText, this.trailingText, required this.onCardPressed, required this.child});

  Widget build(BuildContext context) {
    return WWCardWrapper(
      onPressed: onCardPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leadingText ?? "", style: headingStyle(context)),
              Text(trailingText ?? "", style: headingStyle(context)),
            ],
          ),
          WWVerticalSpacer(8),
          child,
        ],
      ),
    );
  }
}
