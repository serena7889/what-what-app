import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/routes.dart';

class WWLoginScreen extends StatelessWidget {
  static const String pageRoute = "/login_screen_route";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WWPrimaryButton(
        text: "Log In",
        onPressed: () async {
          NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
          print('About to try and login');
          User? user = await client.logIn("serenalambert1731@gmail.com", "pass1234");
          if (user == null) {
            print("FAILED");
            return;
          }
          switch (user.role) {
            case "admin":
              Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);
              return;
            case "leader":
              Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);
              return;
            case "student":
              Navigator.pushReplacementNamed(context, Routes.askQuestionScreenRoute);
              return;
            default:
              break;
          }
        },
      ),
    );
  }
}
