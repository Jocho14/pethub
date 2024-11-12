import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';

class MessageProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to start a conversation or get existing one
  Future<DocumentReference> getOrCreateConversation(
      String otherUserId, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUserId = authProvider.user?.uid;

    // Query for an existing conversation between current user and other user
    QuerySnapshot conversation = await _firestore
        .collection('conversations')
        .where('participants', arrayContains: currentUserId)
        .get();

    // Check if conversation with specific user exists
    DocumentReference? conversationRef;
    for (var doc in conversation.docs) {
      if (doc['participants'].contains(otherUserId)) {
        conversationRef = doc.reference;
        break;
      }
    }

    // If no conversation exists, create a new one
    if (conversationRef == null) {
      conversationRef = await _firestore.collection('conversations').add({
        'participants': [currentUserId, otherUserId],
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    }

    return conversationRef;
  }

  // Method to send a message
  Future<void> sendMessage(
      String conversationId, String text, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUserId = authProvider.user?.uid;

    if (currentUserId == null) return; // Ensure user is logged in

    DocumentReference conversationRef =
        _firestore.collection('conversations').doc(conversationId);
    DocumentReference messageRef = conversationRef.collection('messages').doc();

    // Add the new message document
    await messageRef.set({
      'senderId': currentUserId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message and timestamp on conversation document
    await conversationRef.update({
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    notifyListeners();
  }

  // Fetch messages in a conversation
  Stream<List<QueryDocumentSnapshot>> getMessages(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
