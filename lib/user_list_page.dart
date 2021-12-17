import 'package:flutter/material.dart';
import 'package:flutter_demo_09/user_detail_page.dart';
import 'package:flutter_demo_09/user_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];
  bool loading = true;
  int page = 0;
  ScrollController scrollController = ScrollController();

  findAllUser() {
    User.findAll(++page).then((value) {
      users.addAll(value);
      loading = false;
      setState(() {});
    }).catchError((err) {
      //pesan error
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var triggerFetchMoreData =
          scrollController.position.maxScrollExtent * 0.9;
      if (scrollController.position.pixels > triggerFetchMoreData) {
        findAllUser();
      }
    });
    findAllUser();
  }

  Widget getBody() {
    if (users.isEmpty) {
      if (loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      }
    } else {
      return ListView.builder(
        controller: scrollController,
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return Container(
            padding: const EdgeInsets.all(2),
            height: 150,
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UserDetailPage(userData: user);
                    }),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(user.avatar),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_box_rounded,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    right: 5.0,
                                  ),
                                ),
                                Text(
                                  user.firstName + " " + user.lastName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    right: 5.0,
                                  ),
                                ),
                                Text(user.email),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('User List'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              child: const Icon(
                Icons.refresh,
                size: 30.0,
              ),
              onTap: () {
                page = 0;
                users = [];
                loading = true;
                setState(() {});
                findAllUser();
              },
            ),
          ),
        ],
      ),
      body: getBody(),
      backgroundColor: Colors.purple[100],
    );
  }
}
