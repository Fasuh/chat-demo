import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/http.dart';
import 'package:angel_websocket/server.dart';
import 'socket_controller/chat_controller.dart';
import 'package:logging/logging.dart';

main() async {
  var app = Angel(reflector: MirrorsReflector());
  var ws = AngelWebSocket(app);
  var http = AngelHttp(app);
  await app.configure(ws.configureServer);
  await app.configure(ChatController(ws).configureServer);

  app.get('/', (req, res) => res.write('Hello, world!'));
  app.all("/ws", ws.handleRequest);

  await http.startServer('localhost', 8000);
  app.logger = Logger('main_logger');
  app.logger.onRecord.listen((event) => print(event));

  print('started');
}