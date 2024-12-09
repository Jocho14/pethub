import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/chat_history/chat_history_provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';
import 'package:pethub/screens/message/message_screen.dart';
import 'package:pethub/widgets/chatHistoryTile/chat_history_tile.dart';

class ChatHistoryScreen extends StatefulWidget {
  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch chat history when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatHistoryProvider>(context, listen: false)
          .fetchChatHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
      ),
      body: Consumer<ChatHistoryProvider>(
        builder: (context, chatHistoryProvider, _) {
          if (chatHistoryProvider.conversations.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: chatHistoryProvider.conversations.length,
            itemBuilder: (context, index) {
              final conversationData = chatHistoryProvider.conversations[index];
              final conversation = conversationData['conversation'];
              final lastMessage = conversationData['lastMessage'];
              final participants =
                  List<String>.from(conversation['participants']);
              final otherUserId = participants.firstWhere((id) =>
                  id !=
                  Provider.of<AuthProvider>(context, listen: false).user?.uid);

              return ChatHistoryTile(
                otherUserId: otherUserId,
                lastMessage: lastMessage,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MessageScreen(otherUserId: otherUserId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
