import 'package:what_what_app/models/parent_question_model.dart';
import 'package:what_what_app/models/user_model.dart';

class Slot {
  String id;
  DateTime date;
  User? leader;
  ParentQuestion? question;

  Slot({required this.id, required this.date, required this.leader, required this.question});

  Slot.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        date = DateTime.parse(json['date']),
        leader = json['leader'] == null ? null : User.fromJson(json['leader']),
        question = json['question'] == null ? null : ParentQuestion.fromJson(json['question']);

  // Slot.fromJson(Map<String, dynamic> json) {
  //   this.id = json['_id'];
  //   this.date = DateTime.parse(json['date']);
  //   this.leader = User.fromJson(json['leader']);
  //   this.question = ParentQuestion.fromJson(json['question']);
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['date'] = this.date;
    data['leader'] = this.leader;
    data['question'] = this.question;
    return data;
  }
}
