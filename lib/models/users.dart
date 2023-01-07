class Users {
  int? id;
  String? username;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  Users(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
