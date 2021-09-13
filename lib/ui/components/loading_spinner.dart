import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class WWLoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: WWColor.accentColor,
      ),
    );
  }
}
