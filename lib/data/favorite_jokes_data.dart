import 'dart:convert';
import 'dart:io';

import 'package:lab48/models/joke.dart';

import '../helpers/get_data_path.dart';

Future<void> saveJokes(List<Joke> jokes) async {
  final filePath = await getDataFilePath('jokes');
  final file = File(filePath);

  final jokesMap =
      jokes.map((joke) {
        if (joke.type == 'twopart') {
          return {
            'id': joke.id,
            'type': joke.type,
            'category': joke.category,
            'setup': joke.setup,
            'delivery': joke.delivery,
          };
        } else {
          return {
            'id': joke.id,
            'type': joke.type,
            'category': joke.category,
            'joke': joke.joke,
          };
        }
      }).toList();

  final jokesJson = jsonEncode(jokesMap);

  await file.writeAsString(jokesJson);
}

Future<List<Joke>> loadJokes() async {
  try {
    final filePath = await getDataFilePath('jokes');

    final file = File(filePath);

    final jsonContents = await file.readAsString();

    final jokesMap = jsonDecode(jsonContents) as List<dynamic>;

    return jokesMap.map((jokesMap) {
      return Joke(
        id: jokesMap['id'],
        type: jokesMap['type'],
        category: jokesMap['category'],
        setup: jokesMap['setup'],
        delivery: jokesMap['delivery'],
        joke: jokesMap['joke'],
      );
    }).toList();
  } catch (error) {
    return [];
  }
}
