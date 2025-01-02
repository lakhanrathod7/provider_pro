// class Product {
//   final int id;
//   final String title;
//   final String description;
//   final double price;
//   final double rating;
//   final List<String> images;

//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.rating,
//     required this.images,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       price: json['price'].toDouble(),
//       rating: json['rating'].toDouble(),
//       images: List<String>.from(json['images']),
//     );
//   }
// }
//
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final String category;
  final List<String> images;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.category,
    required this.images,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      rating: json['rating']?.toDouble() ?? 0.0,
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      stock: json['stock'] ?? 0,
    );
  }
}
