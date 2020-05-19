import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_oauth2/angel_oauth2.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';
import 'package:common/model/model.dart';
import 'package:password_hash/password_hash.dart';

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

  @override
  FutureOr<AuthorizationTokenResponse> resourceOwnerPasswordCredentialsGrant(
      Client client,
      String username,
      String password,
      Iterable<String> scopes,
      RequestContext req,
      ResponseContext res) async {
      throw Exception(); // TODO - login
  }

  Future<User> register(
      String username,
      String password,
      RequestContext req,
      ResponseContext res) async {
    final generator = PBKDF2();
    final salt = Salt.generateAsBase64String(32);
    final hash = generator.generateBase64Key(password, salt, 1000, 64);
    final executor = await req.container.make<PostgreSqlExecutor>(PostgreSqlExecutor);
    final user = UserQuery()
      ..values.username = username
      ..values.salt = salt
      ..values.password = hash;
    return user.insert(executor);
  }
}

class PasswordHash {
  final String salt;
  final int iterations;
  final String hash;

  factory PasswordHash.fromAlgorithmResult(String hash) {
    final list = hash.split(",");
    return PasswordHash(list[0], int.parse(list[1]), list[2]);
  }

  PasswordHash(this.salt, this.iterations, this.hash);
}