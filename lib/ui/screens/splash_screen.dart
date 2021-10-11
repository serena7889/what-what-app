import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/components/loading_spinner.dart';
import 'package:what_what_app/ui/routes.dart';

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

  void goToLoginScreen() => Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
  void goToQuestionsTogglerScreen() => Navigator.pushReplacementNamed(context, Routes.questionTogglerScreenRoute);

  Future<void> checkIfLoggedIn() async {
    final client = Provider.of<NetworkingClient>(context, listen: false);
    final token = await client.appState.getToken();
    if (token == null) goToLoginScreen();
    print("TOKEN: after splash: ${client.appState.token}");
    if (client.appState.currentUser == null) await client.getUserForToken();
    goToQuestionsTogglerScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WWLoadingSpinner());
  }
}
