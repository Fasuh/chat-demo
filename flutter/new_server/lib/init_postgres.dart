import 'package:postgres/postgres.dart';

PostgreSQLConnection connectToPostgres(Map configuration) {
  var postgresConfig = configuration['postgres'] as Map;
  var connection = PostgreSQLConnection(
      postgresConfig['host'] as String,
      postgresConfig['port'] as int,
      postgresConfig['database_name'] as String,
      username: postgresConfig['username'] as String,
      password: postgresConfig['password'] as String,
      timeZone: postgresConfig['time_zone'] as String,
      timeoutInSeconds: postgresConfig['timeout_in_seconds'] as int,
      useSSL: postgresConfig['use_ssl'] as bool);
  return connection;
}