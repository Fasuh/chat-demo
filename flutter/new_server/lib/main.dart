import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_websocket/server.dart';
import 'package:hello/authentication/auth_credentials.dart';
import 'package:hello/socket_controller/chat_controller.dart';
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
  await app.configure(configureServer);

  app.get('/', (req, res) => res.write('Hello, world!'));
  app.all("/ws", ws.handleRequest);
  app.group('/auth', (router) {
    router
      ..post('/login', auth.tokenEndpoint);
  });

  await http.startServer('localhost', 8000);
  app.logger = Logger('main_logger');
  app.logger.onRecord.listen((event) => print(event));

  print('started');
}