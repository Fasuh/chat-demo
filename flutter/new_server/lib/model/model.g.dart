// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class TestMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('tests', (table) {
      table.serial('id')..primaryKey();
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('tests');
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class TestQuery extends Query<Test, TestQueryWhere> {
  TestQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = TestQueryWhere(this);
  }

  @override
  final TestQueryValues values = TestQueryValues();

  TestQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'tests';
  }

  @override
  get fields {
    return const ['id', 'created_at', 'updated_at'];
  }

  @override
  TestQueryWhere get where {
    return _where;
  }

  @override
  TestQueryWhere newWhereClause() {
    return TestQueryWhere(this);
  }

  static Test parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Test(
        id: row[0].toString(),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime));
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class TestQueryWhere extends QueryWhere {
  TestQueryWhere(TestQuery query)
      : id = NumericSqlExpressionBuilder<int>(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at');

  final NumericSqlExpressionBuilder<int> id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt];
  }
}

class TestQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  void copyFrom(Test model) {
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Test extends _Test {
  Test({this.id, this.createdAt, this.updatedAt});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  Test copyWith({String id, DateTime createdAt, DateTime updatedAt}) {
    return Test(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Test &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([id, createdAt, updatedAt]);
  }

  @override
  String toString() {
    return "Test(id=$id, createdAt=$createdAt, updatedAt=$updatedAt)";
  }

  Map<String, dynamic> toJson() {
    return TestSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const TestSerializer testSerializer = TestSerializer();

class TestEncoder extends Converter<Test, Map> {
  const TestEncoder();

  @override
  Map convert(Test model) => TestSerializer.toMap(model);
}

class TestDecoder extends Converter<Map, Test> {
  const TestDecoder();

  @override
  Test convert(Map map) => TestSerializer.fromMap(map);
}

class TestSerializer extends Codec<Test, Map> {
  const TestSerializer();

  @override
  get encoder => const TestEncoder();
  @override
  get decoder => const TestDecoder();
  static Test fromMap(Map map) {
    return Test(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null);
  }

  static Map<String, dynamic> toMap(_Test model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class TestFields {
  static const List<String> allFields = <String>[id, createdAt, updatedAt];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
