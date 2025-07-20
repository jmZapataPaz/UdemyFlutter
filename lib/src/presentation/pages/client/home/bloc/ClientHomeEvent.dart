import 'package:equatable/equatable.dart';

abstract class ClientHomeEvent extends Equatable{
  const ClientHomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDrawerPage extends ClientHomeEvent {
  final int pageIndex;

  const ChangeDrawerPage({this.pageIndex = 0});

  @override
  List<Object?> get props => [pageIndex];

}

class Logout extends ClientHomeEvent {
  const Logout();

}