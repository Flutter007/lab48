import 'package:flutter/material.dart';
import 'package:lab48/helpers/request.dart';
import 'package:lab48/models/joke.dart';
import 'package:lab48/widgets/joke_container.dart';
import '../app_routes.dart';
import '../data/favorite_jokes_data.dart';
import '../models/favorites_jokes.dart';
import '../providers/favorites_list_provider.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  Joke? joke;
  bool isLoading = true;
  String? error;
  late FavoritesJokes jokes;
  late FavoritesListProvider listProvider;

  @override
  void initState() {
    super.initState();
    fetchJoke();
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

  void fetchJoke() async {
    try {
      final Map<String, dynamic> jokeData = await request(
        'https://v2.jokeapi.dev/joke/Programming,Christmas?blacklistFlags=nsfw,religious,racist,sexist,explicit',
      );
      setState(() {
        joke = Joke.fromJson(jokeData);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
    loadJoke();
  }

  void addToFav(Joke joke) {
    listProvider.addFavorite(joke);
    saveJokes(listProvider.favorites.favoriteJokes);
  }

  void goToFavorites() async {
    await Navigator.of(context).pushNamed(AppRoutes.favorites);
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = jokes.favoriteJokes.any((j) => j.id == joke!.id);
    final theme = Theme.of(context);
    Widget content;
    if (isLoading && joke == null) {
      content = Center(child: CircularProgressIndicator());
    } else if (error != null) {
      content = Text(error!);
    } else {
      content = JokeContainer(
        jokeCategory: joke!.category,
        jokeBody: joke!.joke ?? '- ${joke!.setup}\n - ${joke!.delivery}',
        fetchData: fetchJoke,
        addToFav: () => addToFav(joke!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Funny Jokes'),
        actions: [
          Text(
            listProvider.favorites.favoriteJokes.length.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          IconButton(
            onPressed: goToFavorites,
            icon: Icon(
              Icons.favorite,
              size: 35,
              color:
                  isFavorite
                      ? theme.colorScheme.error
                      : theme.colorScheme.surface,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
