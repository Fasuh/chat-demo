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

class UserMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('users', (table) {
      table.serial('id')..primaryKey();
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
      table.varChar('username');
      table.varChar('password');
      table.varChar('salt');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('users');
  }
}

class ClientMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('clients', (table) {
      table.serial('id')..primaryKey();
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('clients');
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

class UserQuery extends Query<User, UserQueryWhere> {
  UserQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = UserQueryWhere(this);
  }

  @override
  final UserQueryValues values = UserQueryValues();

  UserQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'users';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'username',
      'password',
      'salt'
    ];
  }

  @override
  UserQueryWhere get where {
    return _where;
  }

  @override
  UserQueryWhere newWhereClause() {
    return UserQueryWhere(this);
  }

  static User parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = User(
        id: row[0].toString(),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        username: (row[3] as String),
        password: (row[4] as String),
        salt: (row[5] as String));
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class UserQueryWhere extends QueryWhere {
  UserQueryWhere(UserQuery query)
      : id = NumericSqlExpressionBuilder<int>(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        username = StringSqlExpressionBuilder(query, 'username'),
        password = StringSqlExpressionBuilder(query, 'password'),
        salt = StringSqlExpressionBuilder(query, 'salt');

  final NumericSqlExpressionBuilder<int> id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final StringSqlExpressionBuilder username;

  final StringSqlExpressionBuilder password;

  final StringSqlExpressionBuilder salt;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, username, password, salt];
  }
}

class UserQueryValues extends MapQueryValues {
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
  String get username {
    return (values['username'] as String);
  }

  set username(String value) => values['username'] = value;
  String get password {
    return (values['password'] as String);
  }

  set password(String value) => values['password'] = value;
  String get salt {
    return (values['salt'] as String);
  }

  set salt(String value) => values['salt'] = value;
  void copyFrom(User model) {
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    username = model.username;
    password = model.password;
    salt = model.salt;
  }
}

class ClientQuery extends Query<Client, ClientQueryWhere> {
  ClientQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = ClientQueryWhere(this);
  }

  @override
  final ClientQueryValues values = ClientQueryValues();

  ClientQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'clients';
  }

  @override
  get fields {
    return const ['id', 'created_at', 'updated_at'];
  }

  @override
  ClientQueryWhere get where {
    return _where;
  }

  @override
  ClientQueryWhere newWhereClause() {
    return ClientQueryWhere(this);
  }

  static Client parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Client(
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

class ClientQueryWhere extends QueryWhere {
  ClientQueryWhere(ClientQuery query)
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

class ClientQueryValues extends MapQueryValues {
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
  void copyFrom(Client model) {
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

@generatedSerializable
class User extends _User {
  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.username,
      this.password,
      this.salt});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  final String username;

  @override
  final String password;

  @override
  final String salt;

  User copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String username,
      String password,
      String salt}) {
    return User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
        password: password ?? this.password,
        salt: salt ?? this.salt);
  }

  bool operator ==(other) {
    return other is _User &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.username == username &&
        other.password == password &&
        other.salt == salt;
  }

  @override
  int get hashCode {
    return hashObjects([id, createdAt, updatedAt, username, password, salt]);
  }

  @override
  String toString() {
    return "User(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, username=$username, password=$password, salt=$salt)";
  }

  Map<String, dynamic> toJson() {
    return UserSerializer.toMap(this);
  }
}

@generatedSerializable
class Client extends _Client {
  Client({this.id, this.createdAt, this.updatedAt});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  Client copyWith({String id, DateTime createdAt, DateTime updatedAt}) {
    return Client(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _Client &&
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
    return "Client(id=$id, createdAt=$createdAt, updatedAt=$updatedAt)";
  }

  Map<String, dynamic> toJson() {
    return ClientSerializer.toMap(this);
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

const UserSerializer userSerializer = UserSerializer();

class UserEncoder extends Converter<User, Map> {
  const UserEncoder();

  @override
  Map convert(User model) => UserSerializer.toMap(model);
}

class UserDecoder extends Converter<Map, User> {
  const UserDecoder();

  @override
  User convert(Map map) => UserSerializer.fromMap(map);
}

class UserSerializer extends Codec<User, Map> {
  const UserSerializer();

  @override
  get encoder => const UserEncoder();
  @override
  get decoder => const UserDecoder();
  static User fromMap(Map map) {
    return User(
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
            : null,
        username: map['username'] as String,
        password: map['password'] as String,
        salt: map['salt'] as String);
  }

  static Map<String, dynamic> toMap(_User model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'username': model.username,
      'password': model.password,
      'salt': model.salt
    };
  }
}

abstract class UserFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    username,
    password,
    salt
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String username = 'username';

  static const String password = 'password';

  static const String salt = 'salt';
}

const ClientSerializer clientSerializer = ClientSerializer();

class ClientEncoder extends Converter<Client, Map> {
  const ClientEncoder();

  @override
  Map convert(Client model) => ClientSerializer.toMap(model);
}

class ClientDecoder extends Converter<Map, Client> {
  const ClientDecoder();

  @override
  Client convert(Map map) => ClientSerializer.fromMap(map);
}

class ClientSerializer extends Codec<Client, Map> {
  const ClientSerializer();

  @override
  get encoder => const ClientEncoder();
  @override
  get decoder => const ClientDecoder();
  static Client fromMap(Map map) {
    return Client(
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

  static Map<String, dynamic> toMap(_Client model) {
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

abstract class ClientFields {
  static const List<String> allFields = <String>[id, createdAt, updatedAt];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
