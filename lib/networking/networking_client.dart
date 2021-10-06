import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/models/slot_model.dart';
import 'package:http/http.dart' as http;
import 'package:what_what_app/models/user_model.dart';
import 'package:what_what_app/networking/app_state.dart';

class NetworkingClient extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.143:8000/api/v1';

  final AppState appState;

  NetworkingClient({required this.appState});

  bool checkStatusCodeValid(http.Response response) {
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Map<String, String> get defaultHeaders {
    Map<String, String> headers = {"Content-Type": "application/json", "Accept": "application/json"};
    if (appState.getPrefetchedToken() != null) {
      headers["Authorization"] = 'Bearer ${appState.token}';
    }
    return headers;
  }

  // Adds child question and return success flag
  Future<bool> addQuestion(String question) async {
    var url = Uri.parse('$baseUrl/questions/unapproved');
    var body = json.encode({'question': question});
    var response = await http.post(url, body: body, headers: defaultHeaders);
    return response.statusCode == 200;
  }

  Future<bool> rejectQuestion(String id) async {
    print("About to reject question: *$id*");
    var url = Uri.parse('$baseUrl/questions/rejected/$id');
    var response = await http.put(url, headers: defaultHeaders);
    return response.statusCode == 200;
  }

  Future<ParentQuestion?> createNewParentQuestion(String question, List<String> ids) async {
    print("About to create new question");
    var url = Uri.parse('$baseUrl/questions');
    var body = json.encode({'question': question, 'children': ids});
    var response = await http.post(url, body: body, headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return null;
    dynamic data = json.decode(response.body)['data'];
    ParentQuestion newQuestion = ParentQuestion.fromJson(data);
    return newQuestion;
  }

  Future<ParentQuestion?> addChildToParentQuestion(String childId, String parentId) async {
    print("About to add child question");
    var url = Uri.parse('$baseUrl/questions/parent/$parentId/child/$childId');
    var response = await http.put(url, headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return null;
    dynamic data = json.decode(response.body)['data'];
    ParentQuestion updatedQuestion = ParentQuestion.fromJson(data);
    return updatedQuestion;
  }

  // Get all available questions (not yet scheduled)
  Future<List<ParentQuestion>> getAvailableQuestions() async {
    print(defaultHeaders);
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/available'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<ParentQuestion> questions = data.map((model) => ParentQuestion.fromJson(model)).toList();
    return questions;
  }

  // Get all answered questions
  Future<List<Slot>> getAnsweredQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/answered'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
  }

  // Get all scheduled questions
  Future<List<Slot>> getScheduledQuestionsList() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/scheduled'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
  }

  Future<List<ChildQuestion>> getUnapprovedQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/unapproved'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    print(data);
    List<ChildQuestion> questions = data.map((model) => ChildQuestion.fromJson(model)).toList();

    return questions;
  }

  Future<List<ChildQuestion>> getRejectedQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/rejected'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<ChildQuestion> questions = data.map((model) => ChildQuestion.fromJson(model)).toList();
    return questions;
  }

  Future<User?> getUser(String id) async {
    http.Response response = await http.get(Uri.parse('$baseUrl/users/$id'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return null;
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    return user;
  }

  Future<User?> getUserForToken() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/users/byToken'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return null;
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    appState.setCurrentUser(user);
    return user;
  }

  Future<User?> logIn(String email, String password) async {
    // Authenticate user
    http.Response response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: defaultHeaders,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    // Check request was successful
    if (!checkStatusCodeValid(response)) return null;

    // Decode user and token
    dynamic data = json.decode(response.body)['data'];
    User user = User.fromJson(data);
    String token = json.decode(response.body)['token'] as String;

    // Store token and current user
    appState.setToken(token);
    appState.setCurrentUser(user);

    // Save token
    appState.setToken(token);

    return user;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appState.reset();
    await prefs.clear();
    return;
  }
}
