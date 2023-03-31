class GameSearch {
  final int id;
  final String name;
  final String publisher;
  final String backgroundUrl;
  final String headerImageUrl;
  final String price;
  final String pathThumbnailUrl;
  final String detailedDescription;

  GameSearch({
    required this.id,
    required this.name,
    required this.publisher,
    required this.backgroundUrl,
    required this.headerImageUrl,
    required this.price,
    required this.pathThumbnailUrl,
    required this.detailedDescription,
  });



  factory GameSearch.fromJson(Map<String, dynamic> json) {

    String gamePrice='';
    if (json['price_overview'] != null) {
      gamePrice = json['price_overview']['final_formatted'];
    } else {
      gamePrice = 'Free-To-Play';
    }

    return GameSearch(
      id: json['steam_appid'],
      name: json['name'],
      publisher: json['publishers'] != null && json['publishers'].isNotEmpty
          ? json['publishers'][0]
          : 'Inconnu',
      backgroundUrl: json['background'],
      headerImageUrl: json['header_image'],
      price: gamePrice,
      pathThumbnailUrl: json['screenshots'][0]['path_thumbnail'],
      detailedDescription: json['detailed_description'],
    );
  }

  @override
  String toString() {
    return 'Game{id: $id, name: $name, publisher: $publisher, backgroundUrl: $backgroundUrl, headerImageUrl: $headerImageUrl, price: $price, pathThumbnailUrl: $pathThumbnailUrl}';
  }
}
