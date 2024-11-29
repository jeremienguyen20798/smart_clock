import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension<Event, State> on Bloc<Event, State> {
  void emitSafety(State state) {
    if (!isClosed) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state);
    }
  }
}

extension CubitExtension<State> on Cubit<State> {
  void emitSafety(State state) {
    if (!isClosed) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      emit(state);
    }
  }
}
