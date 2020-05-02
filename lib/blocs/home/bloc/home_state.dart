part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final int page;
  HomeInitial(this.page);
  @override
  List<Object> get props => [page];
}

class CurrentPage extends HomeState {
  final int page;
  CurrentPage(this.page);
  @override
  List<Object> get props => [page];
}

