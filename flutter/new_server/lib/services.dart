import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';
import 'package:hello/init_postgres.dart';

Future<void> configureServerORM(Angel app) async {
  var connection = connectToPostgres(app.configuration);
  await connection.open();

  app
    ..container.registerSingleton<PostgreSqlExecutor>(PostgreSqlExecutor(connection))
    ..shutdownHooks.add((_) => connection.close());
}