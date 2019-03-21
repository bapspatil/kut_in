class Quote {
  final String quote;

  Quote.fromJson(Map<String, dynamic> json)
      : quote = json['quote'];
}
