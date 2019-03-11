class Quote {
  final String quote;
  final String id;

  Quote(this.quote, this.id);

  Quote.fromJson(Map<String, dynamic> json)
      : quote = json['quote'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'quote': quote,
        'id': id,
      };
}
