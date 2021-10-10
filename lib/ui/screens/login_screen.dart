import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/app_state.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/buttons/primary_button.dart';
import 'package:what_what_app/ui/components/helpers/spacers.dart';
import 'package:what_what_app/ui/components/text_field.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';

class WWLoginScreen extends StatefulWidget {
  static const String pageRoute = "/login_screen_route";

  @override
  _WWLoginScreenState createState() => _WWLoginScreenState();
}

class _WWLoginScreenState extends State<WWLoginScreen> {
  final emailController = TextEditingController(text: "serenalambert1731@gmail.com");
  final passwordController = TextEditingController(text: "pass1234");
  WWPrimaryButtonState loginButtonState = WWPrimaryButtonState.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text("WHAT WHAT", style: WWFonts.fromOptions(context, color: WWColor.accentColor, size: 52, weight: WWFontWeight.light)),
            // WWVerticalSpacer(40),
            Spacer(),
            WWTextField(
              placeholder: "Email",
              controller: emailController,
              style: WWTextFieldStyle.singleLine,
              capitalization: TextCapitalization.none,
            ),
            WWVerticalSpacer(16),
            WWTextField(
              placeholder: "Password",
              controller: passwordController,
              style: WWTextFieldStyle.singleLine,
              obscure: true,
            ),
            // WWVerticalSpacer(40),
            Spacer(),
            WWPrimaryButton(
              text: "Log In",
              onPressed: () => attemptLogin(context),
              state: loginButtonState,
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  void attemptLogin(BuildContext context) async {
    setLoginLoading();
    NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
    AppState appState = Provider.of<AppState>(context, listen: false);
    String email = emailController.text;
    String password = passwordController.text;
    print('About to try and login: $email, $password');
    User? user = await client.logIn(email, password);
    if (user == null) {
      print("FAILED");
      await showLoginError(context);
      setLoginActive();
      return;
    }

    switch (appState.userRole) {
      case UserRole.admin:
        Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);
        break;
      case UserRole.leader:
        Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);
        break;
      case UserRole.student:
        Navigator.pushReplacementNamed(context, Routes.askQuestionScreenRoute);
        break;
      default:
        break;
    }
    // Future.delayed(Duration(seconds: 1), () {
    //   setLoginActive();
    // });
  }

  void setLoginActive() {
    setState(() => loginButtonState = WWPrimaryButtonState.active);
  }

  void setLoginLoading() {
    setState(() => loginButtonState = WWPrimaryButtonState.loading);
  }

  Future<void> showLoginError(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          titleTextStyle: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 24, weight: WWFontWeight.semibold),
          content: Text(
            "Email address or password are incorrect.",
            style: WWFonts.fromOptions(context, color: WWColor.primaryText(context), size: 20),
          ),
        );
      },
    );
  }
}
