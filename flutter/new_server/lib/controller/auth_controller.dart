import 'dart:async';

import "package:angel_framework/angel_framework.dart";
import 'package:common/common.dart';
import 'package:common/model/model.dart';
import 'package:hello/authentication/auth.dart';
import 'package:hello/helper/error_handler.dart';
import 'package:hello/extensions/user.dart';
import 'package:hello/extensions/auth_credentials.dart';

@Expose("/auth")
class AuthController extends Controller {
  final AuthServer _authServer;

  AuthController(this._authServer);

  @Expose("/login", method: "POST")
  login(RequestContext req, ResponseContext res) async =>
      _authServer.tokenEndpoint(req, res);

  @Expose("/register", middleware: const [AuthCredentialsExt.deserializeAuth], method: "POST")
  register(RequestContext req, ResponseContext res, AuthCredentials credentials) async {
    final errors = await credentials.checkCredentials(req);
    if(errors.isEmpty) {
      final user = await _authServer.register(
          credentials.username, credentials.password, req, res);
      return user.username;
    } else {
      throw CustomHttpException.badRequest(message: PomError.BadCredentials, errors: errors);
    }
  }
}