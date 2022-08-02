// ignore_for_file: constant_identifier_names
// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import '../pages/home.dart';
import '../pages/milk_quality_page.dart';
import '../pages/honeyquality_page.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  // ignore: todo
  // TODO: implement initialState
  @override
  NavigationStates get initialState => const HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    // ignore: todo
    // TODO: implement mapEventToState
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield const HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield const MyOrdersPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield const MakeDashboardItems();
        break;
    }
  }
}
