import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addproduct_event.dart';
part 'addproduct_state.dart';

class AddproductBloc extends Bloc<AddproductEvent, AddproductState> {
  @override
  AddproductState get initialState => AddproductInitial();

  @override
  Stream<AddproductState> mapEventToState(
    AddproductEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
