part of 'model.dart';

@Orm()
@serializable
abstract class _User extends Model {
  String get username;
  String get password;
  String get salt;
  @hasMany
  List<_RefreshToken> get tokens;
}