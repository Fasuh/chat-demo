import 'package:angel_framework/angel_framework.dart';
import 'package:common/model/model.dart';
import 'package:hello/extensions/request.dart';
import 'package:hello/helper/auth_token.dart';

extension RefreshTokenExt on RefreshToken {
  static Future<RefreshToken> findToken(RequestContext req, String refreshToken) async {
    CustomAuthorizationTokenResponse.verifyToken(refreshToken);
    final executor = req.getExecutor;
    final query = RefreshTokenQuery()
      ..where.refreshToken.equals(refreshToken);
    return query.getOne(executor);
  }
}