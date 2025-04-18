import 'joke.dart';

class FavoritesJokes {
  List<Joke> favoriteJokes = [];

  void addJokeToFav(Joke joke) {
    if (!favoriteJokes.any((j) => j.id == joke.id)) {
      favoriteJokes.add(joke);
    } else {
      return;
    }
  }

  void removeJokeFromFav(Joke joke) {
    favoriteJokes.remove(joke);
  }
}
