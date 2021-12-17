import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String avatar;

  User({
    this.id = 0,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.avatar = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  static Future<List<User>> findAll(int page) async {
    final url = Uri.parse('https://reqres.in/api/users?page=$page');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var listUser = jsonBody['data'];
      List<User> users = [];
      for (var user in listUser) {
        users.add(User.fromJson(user));
      }
      return users;
    } else {
      throw Exception('Failed to load Users');
    }
  }
}
