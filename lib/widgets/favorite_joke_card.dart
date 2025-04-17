import 'package:flutter/material.dart';

class FavoriteJokeCard extends StatelessWidget {
  final String jokeCategory;
  final String jokeBody;
  final void Function() removeFavorite;
  const FavoriteJokeCard({
    super.key,
    required this.jokeCategory,
    required this.jokeBody,
    required this.removeFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text(jokeCategory, style: theme.textTheme.titleMedium),
          subtitle: Text(
            jokeBody,
            textAlign: TextAlign.justify,
            style: theme.textTheme.titleSmall,
          ),
          leading: IconButton(
            onPressed: removeFavorite,
            icon: Icon(Icons.delete, size: 25, color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }
}
