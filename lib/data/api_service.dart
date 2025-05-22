import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<dynamic>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<dynamic>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }
}