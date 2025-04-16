class Joke {
  final String type;
  final int id;
  final String? setup;
  final String? delivery;
  final String? joke;
  final String category;
  Joke({
    required this.id,
    required this.type,
    required this.category,
    this.setup,
    this.delivery,
    this.joke,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'twopart') {
      return Joke(
        id: json['id'],
        setup: json['setup'],
        delivery: json['delivery'],
        type: json['type'],
        category: json['category'],
      );
    } else {
      return Joke(
        id: json['id'],
        joke: json['joke'],
        type: json['type'],
        category: json['category'],
      );
    }
  }
}
