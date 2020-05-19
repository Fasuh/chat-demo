part of 'model.dart';

enum PomError {
  UserExists,
  InvalidPassword,
  InvalidUsername,
  BadCredentials,
}

extension PomErrorExt on PomError {
  String get toMessage => EnumToString.parseCamelCase(this);

  static PomError fromMessage(String message) => EnumToString.fromString(PomError.values, message);
}