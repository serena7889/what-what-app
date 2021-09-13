import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:http/http.dart' as http;
import 'package:what_what_app/models/user_model.dart';

class NetworkingClient extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.143:8000/api/v1';
  String? token;
  User? currentUser;

  Map<String, String> get headers {
    Map<String, String> h = {"Content-Type": "application/json", "Accept": "application/json"};
    if (token != null) {
      h["Authorization"] = 'Bearer $token';
    }
    return h;
  }

  // Add students question and return success flag
  Future<bool> addQuestion(String question) async {
    var url = Uri.parse('$baseUrl/questions/unapproved');
    var body = json.encode({'question': question});
    var response = await http.post(url, body: body, headers: headers);
    return response.statusCode == 200;
  }

  // Get all available questions (not yet scheduled)
  Future<List<ParentQuestion>> getAvailableQuestions() async {
    print(headers);
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/available'), headers: headers);
    Iterable data = json.decode(response.body)['data'];
    List<ParentQuestion> questions = data.map((model) => ParentQuestion.fromJson(model)).toList();
    return questions;
  }

  // Get all answered questions
  Future<List<Slot>> getAnsweredQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/answered'), headers: headers);
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
  }

  // Get all scheduled questions
  Future<List<Slot>> getScheduledQuestionsList() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/scheduled'), headers: headers);
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
  }

  Future<List<ChildQuestion>> getUnapprovedQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/unapproved'), headers: headers);
    Iterable data = json.decode(response.body)['data'];
    List<ChildQuestion> questions = data.map((model) => ChildQuestion.fromJson(model)).toList();
    return questions;
  }

  Future<User> getUser(String id) async {
    // String userId = "6133e05ea0d78d9196e227c1";
    http.Response response = await http.get(Uri.parse('$baseUrl/users/$id'), headers: headers);
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    return user;
  }

  Future<User> getUserForToken() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/users/byToken'), headers: headers);
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    currentUser = user;
    return user;
  }

  Future<User?> logIn(String email, String password) async {
    // Authenticate user
    http.Response response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: headers,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    // Decode user and token
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    String token = json.decode(response.body)['token'] as String;

    // Store token and current user
    this.token = token;
    this.currentUser = user;

    // Save token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return user;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    currentUser = null;
    await prefs.clear();
    return;
  }
}
