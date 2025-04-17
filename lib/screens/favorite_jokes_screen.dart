import 'package:flutter/material.dart';
import 'package:lab48/models/favorites_jokes.dart';
import 'package:lab48/providers/favorites_list_provider.dart';

import '../models/joke.dart';

class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<FavoriteJokesScreen> createState() => _FavoriteJokesScreenState();
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  late FavoritesJokes jokes;
  late FavoritesListProvider listProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listProvider = FavoritesListProvider.of(context)!;
    jokes = listProvider.favorites;
  }

  void removeFavorite(Joke joke) {
    listProvider.removeFavorite(joke);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Favorites Jokes!'),
            Text(jokes.favoriteJokes.length.toString()),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: jokes.favoriteJokes.length,
              itemBuilder: (ctx, index) {
                final joke = jokes.favoriteJokes[index];
                return ListTile(
                  title: Text(joke.joke ?? '${joke.setup!}\n${joke.delivery}'),
                  subtitle: Text(joke.type),
                  trailing: IconButton(
                    onPressed: () => removeFavorite(joke),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
