part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangeScreen extends HomeEvent {
  final int page;
  ChangeScreen({@required this.page});
  @override
  List<Object> get props => [page];
}



