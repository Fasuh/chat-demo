import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/postgres.dart';
import 'package:hello/init_postgres.dart';
import 'package:file/local.dart';
import 'package:angel_configuration/angel_configuration.dart';
import 'package:common/model/model.dart';

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
    ],
  );
}

main(List<String> args) async => runMigrations(await migrationRunner(), args);