import 'package:flutter/cupertino.dart';
import 'package:lab48/models/favorites_jokes.dart';

import '../models/joke.dart';

class FavoritesListProvider extends InheritedWidget {
  final FavoritesJokes favorites;
  final void Function(Joke joke) addFavorite;
  final void Function(Joke joke) removeFavorite;
  const FavoritesListProvider({
    super.key,
    required super.child,
    required this.favorites,
    required this.addFavorite,
    required this.removeFavorite,
  });
  static FavoritesListProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoritesListProvider>();
  }

  @override
  bool updateShouldNotify(FavoritesListProvider oldWidget) {
    return true;
  }
}
