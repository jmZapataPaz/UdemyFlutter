import 'package:equatable/equatable.dart';

abstract class DriverHomeEvent extends Equatable{
  const DriverHomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDrawerPage extends DriverHomeEvent {
  final int pageIndex;

  const ChangeDrawerPage({this.pageIndex = 0});

  @override
  List<Object?> get props => [pageIndex];

}

class Logout extends DriverHomeEvent{
  const Logout();

}