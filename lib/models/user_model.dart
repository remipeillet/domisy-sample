import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_model.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class UserRestClient {
  factory UserRestClient(Dio dio, {String baseUrl}) = _UserRestClient;

  @GET("/users")
  Future<List<User>> getUsers();

  @GET("/users/{id}")
  Future<User> getUser(@Path("id") String id);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({this.id, this.name, this.username, this.email});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
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

  UserListItemCard({Key key, @required this.user}) : super(key: key);

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
                    ]),
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
                    ]),
              ],
            ),
          );
        });
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
            subtitle: Text(user.name + '\n' + user.email),
          )),
    );
  }
}
