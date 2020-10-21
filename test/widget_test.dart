// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:domisy_sample/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'user_test.dart';

class MockUser extends Mock implements User {}

void main() {
  group('User', () {
    testWidgets('UserList creation without User', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home:UserList(users: new List<User>())));
      final findList = find.byType(UserList);
      final findListItems = find.byType(UserListItemCard);
      //expect(findId, findsOneWidget);
      //expect(findName, findsOneWidget);
      expect(findList, findsOneWidget);
      expect(findListItems, findsNothing);

    });

    testWidgets('UserList creation with one User', (WidgetTester tester) async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/users'))
          .thenAnswer((_) async => http.Response('''
            [{"id": 2, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.de"}]''', 200));
      List<User> users = await User.fetchUsers(client);


      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home:UserList(users: users)));
      final findList = find.byType(UserList);
      final findListItems = find.byType(UserListItemCard);
      expect(findList, findsOneWidget);
      expect(findListItems, findsOneWidget);
      expect(find.byKey(ValueKey('user_list_item_card_2')), findsOneWidget);
    });

    testWidgets('UserList creation with many User', (WidgetTester tester) async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/users'))
          .thenAnswer((_) async => http.Response('''
            [{"id": 2, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.de"},{"id": 3, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.fr"}]''', 200));
      List<User> users = await User.fetchUsers(client);


      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home:UserList(users: users)));
      final findList = find.byType(UserList);
      final findListItems = find.byType(UserListItemCard);
      expect(findList, findsOneWidget);
      expect(findListItems, findsNWidgets(2));
      expect(find.byKey(ValueKey('user_list_item_card_2')), findsOneWidget);
      expect(find.byKey(ValueKey('user_list_item_card_3')), findsOneWidget);
    });

    testWidgets('UserList modal open when tap in Tile', (WidgetTester tester) async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/users'))
          .thenAnswer((_) async => http.Response('''
            [{"id": 2, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.de"},{"id": 3, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.fr"}]''', 200));
      List<User> users = await User.fetchUsers(client);


      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home:UserList(users: users)));
      expect(find.byKey(ValueKey('user_list_item_card_2')), findsOneWidget);
      await tester.pump();
      await tester.pump(Duration(seconds: 10));
      await tester.tap(find.byKey(ValueKey('list_tile_2')));
      await tester.pumpAndSettle(Duration(seconds: 10));
      expect(find.byKey(ValueKey('user_modal')), findsOneWidget);
      expect(find.text('Identifiant'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });
  });

}
