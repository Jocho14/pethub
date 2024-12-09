import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';

class ChatHistoryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _conversations = [];

  List<Map<String, dynamic>> get conversations => _conversations;

  Future<void> fetchChatHistory(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final currentUserId = authProvider.user?.uid;
      if (currentUserId == null) {
        print('User ID is null');
        return;
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('conversations')
          .where('participants', arrayContains: currentUserId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No conversations found');
      } else {
        print('Conversations fetched: ${querySnapshot.docs.length}');
      }

      _conversations = await Future.wait(querySnapshot.docs.map((doc) async {
        final lastMessageSnapshot = await doc.reference
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        final lastMessage = lastMessageSnapshot.docs.isNotEmpty
            ? lastMessageSnapshot.docs.first.data()['text']
            : 'No messages yet';

        return {
          'conversation': doc,
          'lastMessage': lastMessage,
        };
      }).toList());

      notifyListeners();
    } catch (e) {
      print('Error fetching chat history: $e');
    }
  }
}
