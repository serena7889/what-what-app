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

  // Add students question and return success flag
  Future<bool> addQuestion(String question) async {
    var url = Uri.parse('$baseUrl/questions/unapproved');
    var body = json.encode({'question': question});
    var response = await http.post(url, body: body, headers: defaultHeaders);
    return response.statusCode == 200;
  }

  // Get all available questions (not yet scheduled)
  Future<List<ParentQuestion>> getAvailableQuestions() async {
    print(defaultHeaders);
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/available'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<ParentQuestion> questions = data.map((model) => ParentQuestion.fromJson(model)).toList();
    return questions;
    // return getList<ParentQuestion>("/questions/available");
  }

  // Get all answered questions
  Future<List<Slot>> getAnsweredQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/answered'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
    // return getList<Slot>("/questions/answered");
  }

  // Get all scheduled questions
  Future<List<Slot>> getScheduledQuestionsList() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/scheduled'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<Slot> questions = data.map((model) => Slot.fromJson(model)).toList();
    return questions;
    // getList<Slot>("/questions/scheduled");
  }

  Future<List<ChildQuestion>> getUnapprovedQuestions() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/questions/unapproved'), headers: defaultHeaders);
    if (!checkStatusCodeValid(response)) return [];
    Iterable data = json.decode(response.body)['data'];
    List<ChildQuestion> questions = data.map((model) => ChildQuestion.fromJson(model)).toList();
    return questions;
    // getList<ChildQuestion>('/questions/unapproved');
  }

  Future<User?> getUser(String id) async {
    // String userId = "6133e05ea0d78d9196e227c1";
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

  // Future<List<Type>>? getList<Type extends Mappable>(String endpoint, {Map<String, String>? headers}) async {
  //   http.Response response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers ?? defaultHeaders);
  //   Iterable data = json.decode(response.body)['data'];
  //   List<Type> questions = data.map((model) => Type.fromJson(model)).toList() as List<Type>;
  //   return questions;
  // }
}
