import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  final String url = "https://bible-api.com/data/web/JHN"; // Ganti dengan API yang sesuai

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> chaptersJson = jsonData['chapters']; // Ambil array "chapters"

      return chaptersJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}
