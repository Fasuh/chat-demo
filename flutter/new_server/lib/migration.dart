import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/postgres.dart';
import 'package:hello/model/model.dart';
import 'package:postgres/postgres.dart';

var migrationRunner = PostgresMigrationRunner(
  PostgreSQLConnection('127.0.0.1', 5432, 'test'),
  migrations: [
    TestMigration(),
  ],
);