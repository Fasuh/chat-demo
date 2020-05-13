import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetNicknameEvent extends ChatEvent {
  final String nickname;

  SetNicknameEvent(this.nickname);
}

class FetchMessagesEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {}
