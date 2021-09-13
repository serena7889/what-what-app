enum UserRole { student, leader, admin }

class User {
  String id;
  String name;
  String email;
  String role;

  User({required this.id, required this.name, required this.email, required this.role});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        email = json['email'],
        role = json['role'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
