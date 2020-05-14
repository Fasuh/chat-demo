import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialChatState extends ChatState {}

class ConnectingState extends ChatState {}

class ConnectedState extends ChatState {}

class ErrorConnectingState extends ChatState {}

class SendingMessageState extends DataChatState {
  SendingMessageState(List<String> list) : super(list);
}

class FetchingMessagesState extends ChatState {}

class DataChatState extends ChatState {
  final List<String> list;

  DataChatState(this.list);
}