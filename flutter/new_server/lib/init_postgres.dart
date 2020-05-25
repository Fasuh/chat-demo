import 'package:hello/args.dart';
import 'package:postgres/postgres.dart';

PostgreSQLConnection _connectToPostgresFromConfig(Map configuration) {
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

PostgreSQLConnection _connectToPostgresFromUrl(String url) {
  final uri = Uri.parse(url);
  final userInfo = uri.userInfo.split(":");
  return PostgreSQLConnection(
      uri.host,
      uri.port,
      uri.path.replaceFirst("/", ""),
      username: userInfo.first,
      password: userInfo.last,
      timeZone: 'UTC',
      timeoutInSeconds: 30,
      useSSL: false);
}

PostgreSQLConnection connectToPostgres(Map config) {
  if(config['postgre_url'] == null) {
    return _connectToPostgresFromConfig(config);
  } else {
    return _connectToPostgresFromUrl(config['postgre_url'] as String);
  }
}