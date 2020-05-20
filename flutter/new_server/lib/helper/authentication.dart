import 'dart:async';
import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:hello/extensions/user.dart';
import 'package:hello/helper/auth_token.dart';
import 'package:hello/extensions/request.dart';

FutureOr<bool> authenticationMiddleware(RequestContext req, ResponseContext res) {
  try {
    final authorization = req.headers.value(HttpHeaders.authorizationHeader);
    req.params['token'] = CustomAuthorizationTokenResponse.verifyToken(authorization);
    return true;
  } catch (error) {
    throw AngelHttpException.forbidden();
  }
}

FutureOr<bool> authenticationDeserializeUserMiddleware(RequestContext req, ResponseContext res) async {
  await authenticationMiddleware(req, res);
  await req.parseBody();
  final token = req.params['token'] as CustomAuthorizationTokenResponse;
  final id = CustomAuthorizationTokenResponse.getUserId(token.accessToken);
  req.params['user'] = await UserExt.getById(req.getExecutor, id);
  return true;
}