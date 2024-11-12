import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/message/message_provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethub/styles/variables.dart';

class MessageScreen extends StatefulWidget {
  final String otherUserId;

  MessageScreen({required this.otherUserId});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late DocumentReference conversationRef;
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeConversation();
  }

  Future<void> initializeConversation() async {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    conversationRef = await messageProvider.getOrCreateConversation(
        widget.otherUserId, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.otherUserId}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: Provider.of<MessageProvider>(context)
                  .getMessages(conversationRef.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData =
                        messages[index].data() as Map<String, dynamic>?;
                    final isCurrentUser = messageData?['senderId'] ==
                        Provider.of<AuthProvider>(context, listen: false)
                            .user
                            ?.uid;
                    return ListTile(
                      title: Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? AppColors.accentDark
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            messageData?['text'],
                            style: TextStyle(
                                color: isCurrentUser
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Provider.of<MessageProvider>(context, listen: false)
                        .sendMessage(
                      conversationRef.id,
                      _messageController.text,
                      context,
                    );
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
