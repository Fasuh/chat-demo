import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_websocket/server.dart';
import 'package:hello/authentication/auth.dart';
import 'package:hello/controller/auth_controller.dart';
import 'package:hello/controller/chat_controller.dart';
import 'package:hello/controller/test_controller.dart';
import 'package:logging/logging.dart';
import 'services.dart';
import 'package:file/local.dart';

main() async {
  var app = Angel(reflector: MirrorsReflector());
  var ws = AngelWebSocket(app);
  var http = AngelHttp(app);
  var auth = AuthServer();
  var fs = const LocalFileSystem();

  await app.configure(configuration(fs));
  await app.configure(ws.configureServer);
  await app.configure(ChatController(ws).configureServer);
  await app.configure(AuthController(auth).configureServer);
  await app.configure(TestController().configureServer);
  await app.configure(configureServer);

  app.all("/ws", ws.handleRequest);

  await http.startServer('localhost', 8000);
  app.logger = Logger('server');
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  app.logger.log(Level.INFO, "started");
}