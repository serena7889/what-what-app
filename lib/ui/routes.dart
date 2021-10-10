import 'package:what_what_app/ui/screens/ask_question_screen.dart';
import 'package:what_what_app/ui/screens/login_screen.dart';
import 'package:what_what_app/ui/screens/manage_slots_screen.dart';
import 'package:what_what_app/ui/screens/manage_topics_screen.dart';
import 'package:what_what_app/ui/screens/questions_lists_toggler_screen.dart';
import 'package:what_what_app/ui/screens/splash_screen.dart';

class Routes {
  static const String splashScreenRoute = WWSplashScreen.pageRoute;
  static const String loginScreenRoute = WWLoginScreen.pageRoute;

  static const String questionTogglerScreenRoute = WWQuestionsListsTogglerScreen.pageRoute;
  static const String askQuestionScreenRoute = WWAskQuestionScreen.pageRoute;

  static const String manageSlotsScreenRoute = WWManageSlotsScreen.pageRoute;
  static const String manageTopicsScreenRoute = WWManageTopicsScreen.pageRoute;
}
