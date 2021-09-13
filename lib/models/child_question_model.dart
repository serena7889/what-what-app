import 'package:flutter/material.dart';
import 'dart:convert';

enum ChildQuestionStatus { unapproved, rejected, approved }

class ChildQuestion {
  String id;
  String question;
  DateTime dateAsked;
  String status;

  ChildQuestion({required this.id, required this.question, required this.dateAsked, required this.status});

  // ChildQuestion.fromJson(Map<String, dynamic> json) {
  //   id = json['_id'];
  //   question = json['question'];
  //   dateAsked = json['dateAsked'];
  //   status = json['status'];
  // }

  ChildQuestion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        question = json['question'] ?? "",
        dateAsked = DateTime.parse(json['dateAsked']),
        status = json['status'];

  Map<String, dynamic> toJson() {
    print("TRYING TO DECODE CHILD");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['question'] = this.question;
    data['dateAsked'] = this.dateAsked;
    data['status'] = this.status;
    return data;
  }
}
