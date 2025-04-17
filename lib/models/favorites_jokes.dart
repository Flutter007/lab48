import 'joke.dart';

class FavoritesJokes {
  final List<Joke> favoriteJokes = [];

  void addJokeToFav(Joke joke) {
    if (!favoriteJokes.contains(joke)) {
      favoriteJokes.add(joke);
    } else {
      return;
    }
  }

  void removeJokeFromFav(Joke joke) {
    favoriteJokes.remove(joke);
  }
}
