import 'package:angel_framework/angel_framework.dart';
import 'package:angel_oauth2/angel_oauth2.dart';
import 'package:common/model/model.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:hello/extensions/request.dart';

class CustomAuthorizationTokenResponse extends AuthorizationTokenResponse {
  static const String secret = "lkKnXzMjlNULMsCiAU7N5BMrbbDvJ8GD7tS5H1QwzJUMELAqpB87xrM9RwgCBzh";
  static const int expTime = 86400;
  static const int refreshExpTime = 2592000;
  static JWTHmacSha256Signer get _signer => JWTHmacSha256Signer(secret);

  CustomAuthorizationTokenResponse(String accessToken, String refreshToken) : super(accessToken, expiresIn: expTime, refreshToken: refreshToken);

  static Future<CustomAuthorizationTokenResponse> generateResponse(User user) async {
    return CustomAuthorizationTokenResponse(_generateToken(user), _generateToken(user, expTime: refreshExpTime));
  }

  static String _generateToken(User user, {int expTime = expTime}) {
    var builder = new JWTBuilder();
    var token = (builder
      ..expiresAt = new DateTime.now().add(new Duration(seconds: expTime))
      ..setClaim('data', {'userId': user.id}))
        .getSignedToken(_signer);
    return token.toString();
  }

  static JWT verifyToken(String token) {
    try {
      token = token.replaceFirst("bearer ", "").replaceFirst("Bearer ", "");
      var decodedToken = new JWT.parse(token);
      var validator = new JWTValidator();
      validator.validate(decodedToken, signer: _signer).isEmpty ? null : throw Exception();
      return decodedToken;
    } catch (error) {
      throw AngelHttpException.notAuthenticated();
    }
  }

  static int getUserId(String token) {
    var decodedToken = new JWT.parse(token);
    return int.parse(decodedToken.claims['data']['userId']);
  }

  Future saveRefreshToken(RequestContext req) {
    final executor = req.getExecutor;
    final query = RefreshTokenQuery()
      ..values.refreshToken = refreshToken
      ..values.accessToken = accessToken;
//        ..values. = getUserId; TODO - user
    return query.insert(executor);
  }
}