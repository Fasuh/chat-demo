import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';
import 'package:hello/init_postgres.dart';
import 'package:postgres/postgres.dart';

Future<void> configureServer(Angel app) async {
  var connection = connectToPostgres(app.configuration);
  await connection.open();

  app
    ..container.registerSingleton<QueryExecutor>(PostgreSqlExecutor(connection))
    ..shutdownHooks.add((_) => connection.close());
}

