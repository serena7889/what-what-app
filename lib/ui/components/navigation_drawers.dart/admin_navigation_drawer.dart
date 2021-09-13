import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNavigationDrawer extends StatelessWidget {
  const AdminNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WWTheme>(
      builder: (context, theme, widget) => Drawer(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 64, 8, 8),
          color: WWColor.primaryBackground(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WWDrawerButton(
                label: "Questions",
                onTap: () => Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute),
              ),
              WWDrawerButton(
                label: "Ask Question",
                onTap: () => Navigator.pushReplacementNamed(context, Routes.askQuestionScreenRoute),
              ),
              Expanded(
                child: Container(),
              ),
              WWDrawerButton(
                label: theme.lightMode ? "Dark Mode" : "Light Mode",
                onTap: () => theme.toggleMode(),
              ),
              WWDrawerButton(
                label: "Log Out",
                onTap: () async {
                  NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
                  client.logOut();
                  Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
                },
              ),
            ],
          ),
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
