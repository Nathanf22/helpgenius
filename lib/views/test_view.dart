import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return const TestPage();
  }
}


class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<ChatMessage> chatMessages = [];
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    String messageText = messageController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        chatMessages.add(ChatMessage(
          text: messageText,
          isUserMessage: true,
        ));
        // Simulez la réponse de l'agent en ajoutant un message de l'agent (ici, un message de test).
        chatMessages.add(ChatMessage(
          text: 'Agent Response: this is a test response',
          isUserMessage: false,
        ));
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ChatBubble(
                  text: message.text,
                  isUserMessage: message.isUserMessage,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: messageController,
                    decoration: const InputDecoration(hintText: 'Type your message', hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white,),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({
    required this.text,
    required this.isUserMessage,
  });
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatBubble({
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}