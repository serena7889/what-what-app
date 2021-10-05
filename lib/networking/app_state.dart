import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_what_app/models/user_model.dart';

class AppState extends ChangeNotifier {
  String? _token;
  User? _currentUser;

  // TODO: Change to something more secure than shared preferences

  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._token = null;
    this._currentUser = null;
    await prefs.clear();
    return;
  }

  Future<void> setToken(String token) async {
    // if (token == null) return false;
    this._token = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    return;
  }

  void setCurrentUser(User user) {
    this._currentUser = user;
  }

  User? get currentUser {
    return this._currentUser;
  }

  String? get token {
    return this._token;
  }

  Future<String?> getToken() async {
    if (_token != null) return _token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    this._token = token;
    return token;
  }

  String? getPrefetchedToken() {
    return this._token;
  }
}
