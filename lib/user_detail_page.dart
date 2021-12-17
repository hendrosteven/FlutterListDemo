import 'package:flutter/material.dart';
import 'package:flutter_demo_09/user_model.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage({Key? key, required this.userData}) : super(key: key);

  User userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Text(userData.firstName + " " + userData.lastName),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(userData.avatar),
                ),
              ),
            ),
            Text(
              userData.firstName + " " + userData.lastName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              userData.email,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
