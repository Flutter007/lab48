import 'package:flutter/material.dart';
import 'package:lab48/models/favorites_jokes.dart';
import 'package:lab48/providers/favorites_list_provider.dart';

import '../data/favorite_jokes_data.dart';
import '../models/joke.dart';

class FavoritesListState extends StatefulWidget {
  final Widget child;
  const FavoritesListState({super.key, required this.child});

  @override
  State<FavoritesListState> createState() => _FavoritesListStateState();
}

class _FavoritesListStateState extends State<FavoritesListState> {
  final favList = FavoritesJokes();
  void addFavorite(Joke joke) {
    setState(() {
      favList.addJokeToFav(joke);
    });
    saveJokes(favList.favoriteJokes);
  }

  void removeFavorite(Joke joke) {
    setState(() {
      favList.removeJokeFromFav(joke);
    });
    saveJokes(favList.favoriteJokes);
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesListProvider(
      favorites: favList,
      addFavorite: addFavorite,
      removeFavorite: removeFavorite,
      child: widget.child,
    );
  }
}
