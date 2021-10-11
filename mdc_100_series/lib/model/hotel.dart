enum Category { all, small, medium, large}

class Hotel {
  const Hotel({
    required this.category,
    required this.filename,
    required this.star,
    required this.name,
    required this.location,
    required this.number,
    required this.description,
    required this.isHeart,
  });

  final Category category;
  final String filename;
  final int star;
  final String name;
  final String location;
  final String number;
  final String description;
  final bool isHeart;

  String get assetName => 'images/$filename.jpeg';
  String get assetPackage => 'images';

  @override
  String toString() => "$name (fileName=$filename)";
}