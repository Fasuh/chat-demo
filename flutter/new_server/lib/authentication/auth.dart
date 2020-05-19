import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_oauth2/angel_oauth2.dart';
import 'package:common/model/model.dart';
import 'package:hello/extensions/refresh_token.dart';
import 'package:hello/helper/auth_token.dart';
import 'package:hello/helper/error_handler.dart';
import 'package:hello/extensions/user.dart';

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
    final user = await UserExt.getByUsername(req, username);
    if(user?.checkIfPasswordMatches(password) ?? false) {
      final response = await CustomAuthorizationTokenResponse.generateResponse(user);
      await response.saveRefreshToken(req);
      return response;
    } else {
      throw AngelHttpException.notAuthenticated();
    }
  }

  @override
  FutureOr<AuthorizationTokenResponse> refreshAuthorizationToken(Client client,
      String refreshToken, Iterable<String> scopes, RequestContext req, ResponseContext res) async {
    final token = await RefreshTokenExt.findToken(req, refreshToken);
    if(token != null) {
      final userId = CustomAuthorizationTokenResponse.getUserId(refreshToken); // TODO - replace with token.user
      final user = await UserExt.getById(req, userId); // TODO - replace with token.user
      final response = await CustomAuthorizationTokenResponse.generateResponse(user);
      await response.saveRefreshToken(req);
      return response;
    } else {
      throw AngelHttpException.notAuthenticated();
    }
  }

  Future<User> register(String username, String password,
      RequestContext req, ResponseContext res) async {
    final exists = await UserExt.getByUsername(req, username);
    if(exists == null) {
      return UserExt.addNewUser(req, username, password);
    } else {
      throw CustomHttpException.badRequest(errors: [PomError.UserExists]);
    }
  }
}