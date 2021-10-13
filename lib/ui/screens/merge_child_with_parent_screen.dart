import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/back_button.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/question_cards/scheduled_question_card.dart';
import 'package:what_what_app/ui/components/question_lists/generic_question_list.dart';
import 'package:what_what_app/ui/screens/confirm_parent_screen.dart';

class MergeChildWithParentScreen extends StatelessWidget {
  final ChildQuestion child;
  final VoidCallback pendingListRefreshTrigger;

  const MergeChildWithParentScreen({Key? key, required this.child, required this.pendingListRefreshTrigger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<NetworkingClient>(context);
    // return Scaffold(
    //   appBar: AppBar(leading: WWBackButton()),
    //   body: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    //         child: WWPrimaryButton(text: "Create New Question", onPressed: () => goToConfirmScreen(context, child, null)),
    //       ),
    //       GenericQuestionList<ParentQuestion>(
    //         // topPadding: 80,
    //         getQuestions: client.getAvailableQuestions,
    //         cardFromQuestion: (parent, refreshTrigger) {
    //           return WWScheduledQuestionCard(
    //             date: '${parent.children.length} Questions',
    //             answererName: '',
    //             question: parent.text,
    //             onButtonPressed: () => goToConfirmScreen(context, child, parent),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(leading: WWBackButton()),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          GenericQuestionList<ParentQuestion>(
            topPadding: 80,
            getQuestions: client.getAvailableQuestions,
            cardFromQuestion: (parent, refreshTrigger) {
              return WWScheduledQuestionCard(
                date: '${parent.children.length} Questions',
                answererName: '',
                question: parent.text,
                onButtonPressed: () => goToConfirmScreen(context, child, parent),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: WWPrimaryButton(text: "Create New Question", onPressed: () => goToConfirmScreen(context, child, null)),
          )
        ],
      ),
    );
  }

  void goToConfirmScreen(context, ChildQuestion child, ParentQuestion? parentToAddTo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmParentScreen(
        parentToAddTo: parentToAddTo,
        childQuestion: child,
        pendingListRefreshTrigger: pendingListRefreshTrigger,
      );
    }));
  }
}
