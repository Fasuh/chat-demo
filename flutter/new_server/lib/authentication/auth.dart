import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_oauth2/angel_oauth2.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:common/model/model.dart';
import 'package:hello/extensions/refresh_token.dart';
import 'package:hello/helper/auth_token.dart';
import 'package:hello/helper/error_handler.dart';
import 'package:hello/extensions/user.dart';
import 'package:hello/extensions/request.dart';

class AuthServer extends AuthorizationServer<Client, User> {
  @override
  FutureOr<Client> findClient(String clientId) {
    // TODO: implement verifyClient
    return Client();
  }

  @override
  FutureOr<bool> verifyClient(Client client, String clientSecret) {
    // TODO: implement verifyClient
    return true;
  }

  @override
  FutureOr<AuthorizationTokenResponse> resourceOwnerPasswordCredentialsGrant(
      Client client, String username, String password, Iterable<String> scopes,
      RequestContext req, ResponseContext res) async {
    final tx = req.getExecutor;
    final user = await UserExt.getByUsername(tx, username);
    if(user?.checkIfPasswordMatches(password) ?? false) {
      return _generateResponseToken(tx, user);
    } else {
      throw AngelHttpException.notAuthenticated();
    }
  }

  @override
  FutureOr<AuthorizationTokenResponse> refreshAuthorizationToken(Client client,
      String refreshToken, Iterable<String> scopes, RequestContext req, ResponseContext res) async {
    final tx = req.getExecutor;
    final token = await RefreshTokenExt.findToken(tx, refreshToken);
    if(token != null) {
      return _generateResponseToken(tx, token.user);
    } else {
      throw AngelHttpException.notAuthenticated();
    }
  }

  Future<User> register(String username, String password,
      RequestContext req, ResponseContext res) async {
    final tx = req.getExecutor;
    final exists = await UserExt.getByUsername(tx, username);
    if(exists == null) {
      return UserExt.addNewUser(tx, username, password);
    } else {
      throw CustomHttpException.badRequest(errors: [PomError.UserExists]);
    }
  }

  Future<CustomAuthorizationTokenResponse> _generateResponseToken(QueryExecutor tx, User user) async {
    final response = await CustomAuthorizationTokenResponse.generateResponse(user);
    await RefreshTokenExt.addRefreshToken(tx, response);
    return response;
  }
}