import 'package:what_what_app/models/child_question_model.dart';
import 'package:what_what_app/models/topic_model.dart';

class ParentQuestion {
  String id;
  List<ChildQuestion> children;
  List<Topic> topics;
  bool scheduled;
  String text;

  ParentQuestion({required this.id, required this.children, required this.topics, required this.scheduled, required this.text});

  ParentQuestion.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        children = json['children'].cast<ChildQuestion>(),
        topics = json['topics'].cast<Topic>(),
        scheduled = json['scheduled'],
        text = json['text'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['children'] = this.children;
    data['topics'] = this.topics;
    data['scheduled'] = this.scheduled;
    data['text'] = this.text;
    return data;
  }
}
