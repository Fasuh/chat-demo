import 'package:angel_orm/angel_orm.dart';
import 'package:common/model/model.dart';
import 'package:hello/helper/auth_token.dart';

extension RefreshTokenExt on RefreshToken {
  static Future<RefreshToken> findToken(QueryExecutor tx,String refreshToken) async {
    CustomAuthorizationTokenResponse.verifyToken(refreshToken);
    final query = RefreshTokenQuery()
      ..where.refreshToken.equals(refreshToken);
    return query.getOne(tx);
  }

  static Future addRefreshToken(QueryExecutor tx, CustomAuthorizationTokenResponse token) async {
      await tx.transaction((tx) async {
        final userId = CustomAuthorizationTokenResponse.getUserId(
            token.refreshToken);
        await _removeAdditionalTokens(tx, userId);
        return _insertNewToken(tx, userId, token);
      });
  }

  static Future _removeAdditionalTokens(QueryExecutor tx, int userId) {
    final query = RefreshTokenQuery()
      ..where.userId.equals(userId);
    return query.delete(tx);
  }

  static Future _insertNewToken(QueryExecutor tx, int userId, CustomAuthorizationTokenResponse token) {
    final query = RefreshTokenQuery()
      ..values.refreshToken = token.refreshToken
      ..values.accessToken = token.accessToken
      ..values.userId = userId;
    return query.insert(tx);
  }
}