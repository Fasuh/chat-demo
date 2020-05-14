import 'dart:async';
import 'dart:convert';
import 'package:angel_websocket/io.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  WebSockets _ws;
  StreamSubscription _subscription;
  List<String> _messages;

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
    } else if (event is RefreshMessagesEvent) {
      yield* _mapRefreshMessagesEvent();
    }
  }

  Stream<ChatState> _mapSendMessageEvent(SendMessageEvent event) async* {
    try {
      yield SendingMessageState(_messages);
      _ws.sendAction(WebSocketAction(eventName: 'new_message', data: event.message));
      yield DataChatState(_messages);
    } catch (error) {
      print(error);
    }
  }

  Stream<ChatState> _mapRefreshMessagesEvent() async* {
    yield DataChatState(_messages);
    add(SendMessageEvent('kek'));
    print(_messages);
  }

  Stream<ChatState> _mapFetchMessagesEvent() async* {
    try {
      yield FetchingMessagesState();
      _ws.sendAction(WebSocketAction(eventName: 'history'));
      print('ok');
    } catch (error) {
      print(error);
    }
  }

  Stream<ChatState> _mapSetNicknameEvent(SetNicknameEvent event) async* {
    try {
      yield ConnectingState();
      _ws = WebSockets('ws://10.0.2.2:8000/ws');
      await _ws.connect();
      listenToChannel();
      yield ConnectedState();
      yield* _mapFetchMessagesEvent();
    } catch (error) {
      print(error);
      yield ErrorConnectingState();
    }
  }

  void listenToChannel() {
    _subscription = _ws.onData.listen(_decodeData);
  }

  void _decodeData(event) {
    try {
      final action = WebSocketAction.fromJson(jsonDecode(event));
      if (action.eventName == 'history') {
        _messages = action.data.cast<String>().toList();
        add(RefreshMessagesEvent());
      } else if (action.eventName == 'message') {
        _messages = action.data.cast<String>().toList();
        add(RefreshMessagesEvent());
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}