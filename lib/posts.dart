import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Data tidak tersedia"));
          }

          List<Post> posts = snapshot.data!;

          return ListView(
            children: posts.map((Post postData) {
              print("Book ID: ${postData.book_id}, Chapter: ${postData.chapter}"); // Debug output

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(postData: postData),
                      ),
                    );
                   },
                  title: Text(postData.book_id.toString()),
                  subtitle: Text("Chapter ${postData.chapter}"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
