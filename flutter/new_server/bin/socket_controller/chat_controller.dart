import 'dart:async';
import "package:angel_framework/angel_framework.dart";
import "package:angel_websocket/server.dart";

@Expose("/")
class ChatController extends WebSocketController {
  static List<String> messages;
  ChatController(AngelWebSocket ws) : super(ws);

  @override
  void onConnect(WebSocketContext socket) {
    print('connected');
    socket.send('connected', messages);
  }

  @ExposeWs("history")
  void getHistory(WebSocketContext socket, WebSocketAction action) async {
    socket.send('history', messages);
  }

  @ExposeWs("new_message")
  void sendMessage(WebSocketContext socket, WebSocketAction action) async {
    messages.add(action.data['message'] as String);
    broadcast('message', messages);
  }
}