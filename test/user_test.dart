import 'dart:convert';

import 'package:domisy_sample/models/user_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('User', () {
    
    test('returns a List<User> if http call is success', () async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/users'))
        .thenAnswer((_) async => http.Response('''
            [{"id": 2, 
            "name": "test", 
            "username": "test", 
            "email": "test@test.de"}]''', 200));
      expect(await User.fetchUsers(client), isA<List<User>>());
    });

    test('trhow error if http call is not success', () async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/users'))
          .thenAnswer((_) async => http.Response('Not found', 404));
      expect(User.fetchUsers(client), throwsException);
    });
    
    test('create user with empty json', () {
      final User user = User.fromJson(jsonDecode("{}"));
      expect(user.id, null);
      expect(user.username, null);
      expect(user.name, null);
      expect(user.email, null);
    });

    test('create user with empty json', () {
      final User init_user = User(id:2,name: 'Remi', username: 'hytsigu', email: 'remi.peillet@aladom.fr');
      final User user = User.fromJson(jsonDecode(jsonEncode(init_user.toJson())));
      expect(user.id, 2);
      expect(user.username, 'hytsigu');
      expect(user.name, 'Remi');
      expect(user.email, 'remi.peillet@aladom.fr');
    });
  });
}