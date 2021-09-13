import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:what_what_app/ui/styles/fonts.dart';

class WWSplashScreen extends StatefulWidget {
  static const String pageRoute = '/splash_screen';

  @override
  _WWSplashScreenState createState() => _WWSplashScreenState();
}

class _WWSplashScreenState extends State<WWSplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  Future<void> checkIfLoggedIn() async {
    // TODO: Change to something more secure than shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("TOKEN: $token");
    if (token == null) goToLoginScreen();
    NetworkingClient client = Provider.of<NetworkingClient>(context, listen: false);
    client.token = token;
    goToQuestionsTogglerScreen();
  }

  void goToLoginScreen() => Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
  void goToQuestionsTogglerScreen() => Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WWLoadingSpinner());
  }
}
