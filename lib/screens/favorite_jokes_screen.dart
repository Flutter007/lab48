import 'package:flutter/material.dart';
import 'package:lab48/data/favorite_jokes_data.dart';
import 'package:lab48/models/favorites_jokes.dart';
import 'package:lab48/providers/favorites_list_provider.dart';

import '../models/joke.dart';
import '../widgets/favorite_joke_card.dart';

class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<FavoriteJokesScreen> createState() => _FavoriteJokesScreenState();
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  late FavoritesJokes jokes;
  late FavoritesListProvider listProvider;

  @override
  void initState() {
    super.initState();
    loadJoke();
  }

  void loadJoke() async {
    final loadedJoke = await loadJokes();
    setState(() {
      listProvider.favorites.favoriteJokes = loadedJoke;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listProvider = FavoritesListProvider.of(context)!;
    jokes = listProvider.favorites;
  }

  void removeFavorite(Joke joke) {
    listProvider.removeFavorite(joke);
    saveJokes(listProvider.favorites.favoriteJokes);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Favorites Jokes!'),
            Text('${jokes.favoriteJokes.length} 🫰'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          jokes.favoriteJokes.isNotEmpty
              ? Expanded(
                child: ListView.builder(
                  itemCount: jokes.favoriteJokes.length,
                  itemBuilder: (ctx, index) {
                    final joke = jokes.favoriteJokes[index];
                    return FavoriteJokeCard(
                      jokeBody:
                          joke.joke ??
                          ' - ${joke.setup!}\n  - ${joke.delivery}',
                      jokeCategory: joke.category,
                      removeFavorite: () => removeFavorite(joke),
                    );
                  },
                ),
              )
              : Center(
                child: Text(
                  'No jokes in favorites!',
                  style: theme.textTheme.titleLarge,
                ),
              ),
        ],
      ),
    );
  }
}
