import 'package:angel_framework/angel_framework.dart';
import 'package:common/model/model.dart';
import 'package:hello/extensions/request.dart';
import 'package:password_hash/password_hash.dart';

extension UserExt on User {
  static Future<User> getById(RequestContext req, int userId) async {
    final query = UserQuery()
      ..where.id.equals(userId);
    return _getSingleFromQuery(req, query);
  }

  static Future<User> getByUsername(RequestContext req, String username) async {
    final query = UserQuery()
      ..where.username.equals(username);
    return _getSingleFromQuery(req, query);
  }

  static Future<bool> nameExists(RequestContext req, String username) async {
    final query = UserQuery()
      ..where.username.equals(username);
    return (await _getSingleFromQuery(req, query)) != null;
  }

  static Future<User> _getSingleFromQuery(RequestContext req, UserQuery query) {
    final executor = req.getExecutor;
    return query.getOne(executor);
  }

  static Future<User> addNewUser(RequestContext req, String username, String password) {
    final executor = req.getExecutor;
    final salt = Salt.generateAsBase64String(32);
    final hash = _hashPassword(password, salt);
    final user = UserQuery()
      ..values.username = username
      ..values.salt = salt
      ..values.password = hash;
    return user.insert(executor);
  }

  bool checkIfPasswordMatches(String password) {
    final hash = _hashPassword(password, salt);
    return hash == this.password;
  }

  static String _hashPassword(String password, String salt) {
    final generator = PBKDF2();
    return generator.generateBase64Key(password, salt, 1000, 64);
  }
}