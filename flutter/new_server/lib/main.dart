import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_production/angel_production.dart';
import 'package:angel_websocket/server.dart';
import 'package:hello/authentication/auth.dart';
import 'package:hello/controller/auth_controller.dart';
import 'package:hello/controller/chat_controller.dart';
import 'package:hello/controller/test_controller.dart';
import 'package:file/local.dart';
import 'package:hello/services.dart';

main(List<String> args) => Runner('pom', configureServer, reflector: MirrorsReflector()).run(args);

Future configureServer(Angel app) async {
  var auth = AuthServer();
  var fs = const LocalFileSystem();
  final ws = AngelWebSocket(app);

  await app.configure(configuration(fs));
  await app.configure(ws.configureServer);
  await app.configure(ChatController(ws).configureServer);
  await app.configure(AuthController(auth).configureServer);
  await app.configure(TestController().configureServer);
  await app.configure(configureServerORM);

//  app.all("/ws", ws.handleRequest); TODO - test
}