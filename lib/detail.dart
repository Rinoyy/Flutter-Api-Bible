import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class DetailPage extends StatefulWidget {
  final Post postData;

  DetailPage({required this.postData});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<dynamic> verses = []; // List untuk menyimpan ayat

  @override
  void initState() {
    super.initState();
    fetchVerses(); // Ambil data ayat saat halaman dibuka
  }

  // Fungsi untuk mengambil data ayat dari API
  Future<void> fetchVerses() async {
    try {
      final response = await http.get(Uri.parse(
          "https://bible-api.com/data/web/${widget.postData.book_id}/${widget.postData.chapter}"));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          verses = data["verses"]; // Ambil daftar ayat
        });
      } else {
        throw Exception("Gagal mengambil data ayat");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.postData.book} - Chapter ${widget.postData.chapter}")),
      body: verses.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loading saat data diambil
          : ListView.builder(
              itemCount: verses.length,
              itemBuilder: (context, index) {
                var verse = verses[index];
                return ListTile(
                  leading: Text(verse["verse"].toString()), // Nomor ayat
                  title: Text(verse["text"]), // Isi ayat
                );
              },
            ),
    );
  }
}
