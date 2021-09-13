import 'package:what_what_app/networking/networking_client.dart';
import 'package:what_what_app/ui/routes.dart';
import 'package:what_what_app/ui/screens/ask_question_screen.dart';
import 'package:what_what_app/ui/screens/login_screen.dart';
import 'package:what_what_app/ui/screens/questions_lists_toggler_screen.dart';
import 'package:what_what_app/ui/screens/splash_screen.dart';
import 'package:what_what_app/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WWTheme>(
      create: (_) => WWTheme(),
      child: ChangeNotifierProvider<NetworkingClient>(
        create: (_) => NetworkingClient(),
        child: Consumer<WWTheme>(
          builder: (context, theme, _) => MaterialApp(
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              primaryColor: WWColor.accentColor,
            ),
            themeMode: theme.lightMode ? ThemeMode.light : ThemeMode.dark,
            initialRoute: Routes.splashScreenRoute,
            routes: {
              Routes.splashScreenRoute: (context) => WWLoginScreen(),
              Routes.loginScreenRoute: (context) => WWLoginScreen(),
              Routes.questionTogglerScreenRoute: (context) => WWQuestionsListsTogglerScreen(),
              Routes.askQuestionScreenRoute: (context) => WWAskQuestionScreen(),
            },
          ),
        ),
      ),
    );
  }
}
