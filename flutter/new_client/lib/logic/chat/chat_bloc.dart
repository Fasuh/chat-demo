import 'dart:async';
import 'package:angel_websocket/io.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  WebSockets ws;

  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event,) async* {
    if (event is SetNicknameEvent) {
      yield* _mapSetNicknameEvent(event);
    } else if (event is FetchMessagesEvent) {
      yield* _mapFetchMessagesEvent();
    } else if (event is SendMessageEvent) {
      yield* _mapSendMessageEvent(event);
    }
  }

  Stream<ChatState> _mapSendMessageEvent(SendMessageEvent event) async* {

  }

  Stream<ChatState> _mapFetchMessagesEvent() async* {

  }

  Stream<ChatState> _mapSetNicknameEvent(SetNicknameEvent event) async* {
    try {
      yield ConnectingState();
//      var url = 'http://10.0.2.2:65090';
//      var response = await get(url);
//      print(response);
      ws = WebSockets('ws://10.0.2.2:51920/ws');
      await ws.connect();
      print('connected');
      yield ConnectedState();
    } catch (error) {
      print(error);
      yield ErrorConnectingState();
    }
  }
}