import 'package:provider/provider.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/app_state.dart';
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

  final availablePage = WWTabPage(
    tabText: "Available",
    page: AvailableQuestionsList(),
  );

  final answeredPage = WWTabPage(
    tabText: "Answered",
    page: AnsweredQuestionsList(),
  );

  final scheduledPage = WWTabPage(
    tabText: "Scheduled",
    page: ScheduledQuestionsList(),
  );

  final pendingPage = WWTabPage(
    tabText: "Pending",
    page: UnapprovedQuestionsList(),
  );

  final rejectedPage = WWTabPage(
    tabText: "Rejected",
    page: RejectedQuestionList(),
  );

  List<WWTabPage> getPages(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final role = appState.userRole;
    switch (role) {
      case UserRole.admin:
        return [availablePage, answeredPage, scheduledPage, pendingPage, rejectedPage];
      case UserRole.leader:
        return [availablePage, answeredPage, scheduledPage];
      case UserRole.student:
        return [scheduledPage, answeredPage];
      default:
        return [];
    }
  }

  @override
  _WWQuestionsListsTogglerScreenState createState() => _WWQuestionsListsTogglerScreenState();
}

class _WWQuestionsListsTogglerScreenState extends State<WWQuestionsListsTogglerScreen> with TickerProviderStateMixin {
  late TabController tabController = TabController(
    length: widget.getPages(context).length,
    vsync: this,
  );

  Widget get tabView {
    return TabBarView(
      controller: tabController,
      children: widget.getPages(context).map((tab) => tab.page).toList(),
    );
  }

  Widget get tabBar {
    return WWTextTabBar(
      controller: tabController,
      pages: widget.getPages(context),
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
