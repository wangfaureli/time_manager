class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String firstname;
  final String lastname;
  final DateTime birthday;
  final int roleId;

  User({this.id, this.username, this.password, this.email, this.firstname, this.lastname, this.birthday, this.roleId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      birthday: json['birthday'],
      roleId: json['roleId'],
    );
  }
}