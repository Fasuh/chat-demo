import 'package:angel_orm/angel_orm.dart';
import 'package:common/model/model.dart';
import 'package:password_hash/password_hash.dart';

extension UserExt on User {
  static Future<User> getById(QueryExecutor tx, int userId) async {
    final query = UserQuery()
      ..where.id.equals(userId);
    return _getSingleFromQuery(tx, query);
  }

  static Future<User> getByUsername(QueryExecutor tx, String username) async {
    final query = UserQuery()
      ..where.username.equals(username);
    return _getSingleFromQuery(tx, query);
  }

  static Future<bool> nameExists(QueryExecutor tx, String username) async =>
    (await getByUsername(tx, username)) != null;

  static Future<User> _getSingleFromQuery(QueryExecutor tx, UserQuery query) {
    return query.getOne(tx);
  }

  static Future<User> addNewUser(QueryExecutor tx, String username, String password) {
    final salt = Salt.generateAsBase64String(32);
    final hash = _hashPassword(password, salt);
    final user = UserQuery()
      ..values.username = username
      ..values.salt = salt
      ..values.password = hash;
    return user.insert(tx);
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