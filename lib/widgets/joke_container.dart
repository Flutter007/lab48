import 'package:flutter/material.dart';

class JokeContainer extends StatelessWidget {
  final String jokeCategory;
  final String jokeBody;
  final void Function() fetchData;
  final void Function() addToFav;
  const JokeContainer({
    super.key,
    required this.jokeCategory,
    required this.jokeBody,
    required this.fetchData,
    required this.addToFav,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(14),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Category:$jokeCategory',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              jokeBody,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: fetchData, child: Text('Next! ➡️')),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: addToFav,
                  child: Text('Favorites 🫰'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
