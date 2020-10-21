import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({this.id, this.name, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'name': name,
        'email': email,
      };

  static List<User> _parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>> fetchUsers(http.Client client) async {
    final response = await client.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      return _parseUsers(response.body);
    }
    throw Exception('Failed to load post');
  }

}

class UserList extends StatelessWidget {

  final List<User> users;

  UserList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserListItemCard(
            key: ValueKey('user_list_item_card_${users[index].id}'),
            user: users[index]);
      },
    );
  }
}

class UserListItemCard extends StatelessWidget {
  final User user;

  UserListItemCard({Key key, @required this.user}) : super(key:key);

  Future<void> _open_user_modal(@required context, @required User user) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            key: ValueKey('user_modal'),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Identifiant',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            user.id.toString(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Username',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            user.username,
                          ),
                        ],
                      ),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Nom',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            user.name,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            user.email,
                          ),
                        ],
                      ),
                    ]
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: SizedBox(
          height: 100,
          child: ListTile(
            contentPadding: EdgeInsets.all(20.0),
            key: ValueKey('list_tile_${user.id}'),
            onTap: () async {
              await _open_user_modal(context, user);
            },
            leading: Text(user.id.toString()),
            title: Text(user.username),
            subtitle: Text(user.name+'\n'+user.email),
          )
        ),
    );
  }
}