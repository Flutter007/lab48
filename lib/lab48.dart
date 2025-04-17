import 'package:flutter/material.dart';
import 'package:lab48/providers/favorites_list_state.dart';
import 'package:lab48/screens/favorite_jokes_screen.dart';
import 'package:lab48/screens/joke_screen.dart';

import 'app_routes.dart';

class Lab48 extends StatelessWidget {
  const Lab48({super.key});

  @override
  Widget build(BuildContext context) {
    return FavoritesListState(
      child: MaterialApp(
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => JokeScreen(),
          AppRoutes.favorites: (context) => FavoriteJokesScreen(),
        },
      ),
    );
  }
}
