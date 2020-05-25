import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/postgres.dart';
import 'package:common/model/model.dart';
import 'package:hello/init_postgres.dart';
import 'package:file/local.dart';
import 'package:angel_configuration/angel_configuration.dart';

Future<PostgresMigrationRunner> migrationRunner() async {
  var fs = const LocalFileSystem();
  final config = await loadStandaloneConfiguration(fs);
  final connection = connectToPostgres(config);

  return PostgresMigrationRunner(
    connection,
    connected: false,
    migrations: [
      TestMigration(),
      UserMigration(),
      ClientMigration(),
      RefreshTokenMigration(),
    ],
  );
}

main(List<String> args) async {
  return runMigrations(await migrationRunner(), args);
}