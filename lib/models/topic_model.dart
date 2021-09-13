class Topic {
  String id;
  String name;

  Topic({required this.id, required this.name});

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
