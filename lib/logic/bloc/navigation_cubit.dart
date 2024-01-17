import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:calibrar_activity/logic/constants/navigation_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationBarItem.reddit, 0));

  void getNavigationBarItem(NavigationBarItem navbarItem) {
    switch (navbarItem) {
      case NavigationBarItem.reddit:
        emit(const NavigationState(NavigationBarItem.reddit, 0));
        break;
      case NavigationBarItem.rickAndMorty:
        emit(const NavigationState(NavigationBarItem.rickAndMorty, 1));
        break;
    }
  }
}