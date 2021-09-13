import 'package:what_what_app/ui/components/navigation_drawers.dart/admin_navigation_drawer.dart';
import 'package:what_what_app/ui/components/question_lists/answered_questions_list.dart';
import 'package:what_what_app/ui/components/question_lists/available_questions_list.dart';
import 'package:what_what_app/ui/components/question_lists/scheduled_questions_list.dart';
import 'package:what_what_app/ui/components/question_lists/unapproved_questions_list.dart';
import 'package:what_what_app/ui/components/tab_bar.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class WWQuestionsListsTogglerScreen extends StatefulWidget {
  static const String pageRoute = "/questions_lists_toggler_screen";

  final List<WWTabPage> pages = [
    WWTabPage(
      tabText: "Available",
      page: AvailableQuestionsList(),
    ),
    WWTabPage(
      tabText: "Answered",
      page: AnsweredQuestionsList(),
    ),
    WWTabPage(
      tabText: "Scheduled",
      page: ScheduledQuestionsList(),
    ),
    WWTabPage(
      tabText: "Pending",
      page: UnapprovedQuestionsList(),
    ),
  ];

  @override
  _WWQuestionsListsTogglerScreenState createState() => _WWQuestionsListsTogglerScreenState();
}

class _WWQuestionsListsTogglerScreenState extends State<WWQuestionsListsTogglerScreen> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    length: widget.pages.length,
    vsync: this,
  );

  Widget get tabView {
    return TabBarView(
      controller: tabController,
      children: widget.pages.map((tab) => tab.page).toList(),
    );
  }

  Widget get tabBar {
    return WWTextTabBar(
      controller: tabController,
      pages: widget.pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNavigationDrawer(),
      appBar: AppBar(
        title: Text("Questions"),
      ),
      backgroundColor: WWColor.primaryBackground(context),
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: tabBar,
            ),
            Expanded(
              child: tabView,
            )
          ],
        ),
      ),
    );
  }
}
