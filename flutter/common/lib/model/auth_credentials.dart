part of 'model.dart';

@serializable
abstract class _AuthCredentials {
  @hasOne
  _Client get client;
  String get username;
  String get password;
  List<String> get scopes;
}