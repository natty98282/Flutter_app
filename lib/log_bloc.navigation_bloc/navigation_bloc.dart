// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: constant_identifier_names
// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import '../auth/login_screen.dart';
import '../auth/registration.dart';

enum NavigationEvents {
  LoginPageClickedEvent,
  RegistrationClickedEvent,
  ExitClickEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  // ignore: todo
  // TODO: implement initialState
  @override
  NavigationStates get initialState => const LoginScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    // ignore: todo
    // TODO: implement mapEventToState
    switch (event) {
      case NavigationEvents.LoginPageClickedEvent:
        yield const LoginScreen();
        break;
      case NavigationEvents.RegistrationClickedEvent:
        yield const RegistrationScreen();
        break;
      case NavigationEvents.ExitClickEvent:
        break;
    }
  }
}
