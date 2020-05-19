import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';

extension RequestContextExt on RequestContext {
  PostgreSqlExecutor get getExecutor => container.make<PostgreSqlExecutor>(PostgreSqlExecutor);
}