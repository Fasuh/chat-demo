import 'dart:async';

import "package:angel_framework/angel_framework.dart";
import 'package:common/common.dart';
import 'package:common/common.dart';
import 'package:hello/authentication/auth.dart';

@Expose("/auth")
class AuthController extends Controller {
  final AuthServer _authServer;

  AuthController(this._authServer);

  @Expose("/login", method: "POST")
  login(RequestContext req, ResponseContext res) async =>
      _authServer.tokenEndpoint(req, res);

  @Expose("/register", middleware: const [_deserializeAuth], method: "POST")
  register(RequestContext req, ResponseContext res, _AuthCredentials credentials) async {
    PasswordValidator passwordValidator = PasswordValidator();
    EmailValidator emailValidator = EmailValidator();
    if(emailValidator.validate(credentials.username) && passwordValidator.validate(credentials.password)) {
      final user = await _authServer.register(
          credentials.username, credentials.password, req, res);
      return user.username;
    } else {
      throw AngelHttpException.badRequest(message: "bad_credentials", errors: ['bad_credentials']);
    }
  }
}

FutureOr<bool> _deserializeAuth(RequestContext req, ResponseContext res) async {
  await req.parseBody();
  final Client client = ClientDecoder().convert(req.bodyAsMap['client'] ?? {});
  final String username = req.bodyAsMap['username'] as String;
  final String password = req.bodyAsMap['password'] as String;
  final List<String> scopes = req.bodyAsMap['scopes'] as List<String>;
  req.params['credentials'] = _AuthCredentials(client, username, password, scopes);
  return true;
}

class _AuthCredentials {
  final Client client;
  final String username;
  final String password;
  final List<String> scopes;

  _AuthCredentials(this.client, this.username, this.password, this.scopes);
}