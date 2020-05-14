import 'dart:async';

import 'package:angel_oauth2/angel_oauth2.dart';

import '../model/client.dart';
import '../model/user.dart';


class AuthServer extends AuthorizationServer<Client, User> {
  @override
  FutureOr<Client> findClient(String clientId) {
    // TODO: implement findClient
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> verifyClient(Client client, String clientSecret) {
    // TODO: implement verifyClient
    throw UnimplementedError();
  }
}