part of 'model.dart';

@Orm()
@serializable
abstract class _RefreshToken extends Model {
  String get refreshToken;
  String get accessToken;
  @belongsTo
  _User get user;
}