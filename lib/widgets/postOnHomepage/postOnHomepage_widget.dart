import 'package:flutter/material.dart';
import 'package:pethub/models/postOnHomepage/postOnHomepage_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    // Pobranie wysokości ekranu
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            post.imageUrl,
            height: 180,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  post.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamiczny odstęp
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/paws.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text('Breed: ${post.breed}', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamiczny odstęp
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/location-pin.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text('Location: ${post.location}', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02), // Dynamiczny odstęp
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/clock.png',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 8),
                    Text('Date: ${post.date}', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
