import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialChatState extends ChatState {}

class ConnectingState extends ChatState {}

class ConnectedState extends ChatState {}

class ErrorConnectingState extends ChatState {}

class SendingMessageState extends ChatState {}