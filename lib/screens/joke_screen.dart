import 'package:flutter/material.dart';
import 'package:lab48/helperts/request.dart';
import 'package:lab48/models/joke.dart';

import '../app_routes.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  Joke joke = Joke(id: 0, type: '', category: '');
  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  void fetchJoke() async {
    try {
      final Map<String, dynamic> jokeData = await request(
        'https://v2.jokeapi.dev/joke/Any',
      );
      setState(() {
        joke = Joke.fromJson(jokeData);
      });
    } catch (e) {
      //
    }
  }

  void goToFavorites() async {
    await Navigator.of(context).pushNamed(AppRoutes.favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funny Jokes'),
        actions: [
          IconButton(onPressed: goToFavorites, icon: Icon(Icons.favorite)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(joke.category),
            Text(joke.joke ?? '${joke.setup!}\n${joke.delivery!}'),
            ElevatedButton(onPressed: fetchJoke, child: Text('Next')),
          ],
        ),
      ),
    );
  }
}
