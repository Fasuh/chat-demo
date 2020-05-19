import "package:angel_framework/angel_framework.dart";
import "package:angel_websocket/server.dart";

@Expose("/chat")
class ChatController extends WebSocketController {
  static List<String> messages = ['test', 'test2'];
  ChatController(AngelWebSocket ws) : super(ws);

  @override
  void onConnect(WebSocketContext socket) {
    socket.send('connected', messages);
  }

  @ExposeWs("history")
  getHistory(WebSocketContext socket, WebSocketAction action) async {
    socket.send('history', messages);
    return messages;
  }

  @ExposeWs("new_message")
  sendMessage(WebSocketContext socket, WebSocketAction action) async {
    messages.add(action.data as String);
    broadcast('message', messages, filter: (client) async => client.request.container.has(String));
  }
}