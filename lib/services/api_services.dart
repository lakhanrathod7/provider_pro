import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['products'] as List;
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> fetchProductDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/search?q=$query'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['products'] as List;
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Search failed');
    }
  }
}
