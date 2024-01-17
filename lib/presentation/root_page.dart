import 'package:calibrar_activity/logic/constants/navigation_bar_items.dart';
import 'package:calibrar_activity/presentation/pages/reddit_page.dart';
import 'package:calibrar_activity/presentation/pages/rick_and_morty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calibrar_activity/logic/bloc/navigation_cubit.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibrar Activity'),
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Reddit',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Rick and Morty',
              )
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavigationBarItem(NavigationBarItem.reddit);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavigationBarItem(NavigationBarItem.rickAndMorty);
              } 
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavigationBarItem.reddit) {
          return const RedditPage();
        } else if (state.navbarItem == NavigationBarItem.rickAndMorty) {
          return const RickAndMortyPage();
        }
        return Container();
      }),
    );
  }
}