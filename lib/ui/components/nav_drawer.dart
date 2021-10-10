import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/app_state.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WWNavDrawer extends StatelessWidget {
  const WWNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<WWTheme>(context);
    final appState = Provider.of<AppState>(context);
    final currentUserName = appState.currentUser?.name ?? "Not found";

    final profileButton = WWDrawerButton(
      label: currentUserName,
      onTap: () => {}, // TODO: Go to profile page
    );
    final questionsButton = WWDrawerButton(
      label: "Questions",
      onTap: () => Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute),
    );
    final askQuestionButton = WWDrawerButton(
      label: "Ask Question",
      onTap: () => Navigator.pushReplacementNamed(context, Routes.askQuestionScreenRoute),
    );
    final manageSlotsButton = WWDrawerButton(
      label: "Manage Slots",
      onTap: () => Navigator.pushReplacementNamed(context, Routes.manageSlotsScreenRoute),
    );
    final manageTopicsButton = WWDrawerButton(
      label: "Manage Topics",
      onTap: () => Navigator.pushReplacementNamed(context, Routes.manageTopicsScreenRoute),
    );
    final spacer = Expanded(
      child: Container(),
    );
    final styleButton = WWDrawerButton(
      label: theme.lightMode ? "Dark Mode" : "Light Mode",
      onTap: () => theme.toggleMode(),
    );
    final logOutButton = WWDrawerButton(
      label: "Log Out",
      onTap: () async {
        NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
        client.logOut();
        Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
      },
    );

    List<Widget> items = [profileButton];

    switch (appState.userRole) {
      case UserRole.admin:
        items.addAll([questionsButton, askQuestionButton, manageSlotsButton, manageTopicsButton]);
        break;
      case UserRole.leader:
        items.addAll([questionsButton, askQuestionButton]);
        break;
      case UserRole.student:
        items.addAll([questionsButton, askQuestionButton]);
        break;
      default:
        break;
    }
    items.addAll([spacer, styleButton, logOutButton]);

    return Drawer(
      child: Container(
        padding: EdgeInsets.fromLTRB(32, 64, 8, 8),
        color: WWColor.primaryBackground(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }
}

class WWDrawerButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const WWDrawerButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        child: Text(
          label,
          style: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 20, weight: WWFontWeight.semibold),
        ),
      ),
    );
  }
}
