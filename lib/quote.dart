class Quote {
  final String quote;
  final String id;

  Quote.fromJson(Map<String, dynamic> json)
      : quote = json['quote'],
        id = json['id'];

}
