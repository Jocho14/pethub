// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethub/widgets/postOnHomepage/postOnHomepage_widget.dart';
import 'package:pethub/screens/details/post_details_screen.dart';
import 'package:pethub/screens/register_new_post/create_new_post_screen.dart';
import 'package:pethub/models/home/PostModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Funkcja do pobierania danych z Firestore
  Future<void> fetchPosts() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('animals').get();
    setState(() {
      posts = querySnapshot.docs.map((doc) {
        return PostModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Przejdź do strony dodawania ogłoszenia
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostPage(refreshPosts: fetchPosts),  // Przekaż funkcję refresh
                ),
              );
            },
          )
        ],
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())  // Ładowanie danych
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Po kliknięciu przechodzimy na stronę szczegółów
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailsPage(post: posts[index]),  // Przekazujemy post
                      ),
                    );
                  },
                  child: PostCard(post: posts[index]),  // Wyświetlamy kartę z postem
                );
              },
            ),
    );
  }
}
