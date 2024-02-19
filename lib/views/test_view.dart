import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helpgenius/model/message_model.dart';
import 'package:helpgenius/viewsModel/test_view_model.dart';

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
  TestViewModel viewModel = TestViewModel();
  List<String> agentsNames = [];
  String? selectedAgent = '' ;
  int agentID = -1;
  List<ChatMessage> chatMessages = [];
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    String messageText = messageController.text;
    viewModel.sendMessage(agentID, messageText).then((value) {
      //update the history if everything good
      viewModel.getHistory(agentID).then((history) {
        chatMessages = history;
        setState(() {
          
        });
      });
      messageController.clear();
    });
    if (messageText.isNotEmpty) {
      // setState(() {
      //   chatMessages.add(ChatMessage(
      //     text: messageText,
      //     isUserMessage: true,
      //   ));
      //   // Simulez la réponse de l'agent en ajoutant un message de l'agent (ici, un message de test).
      //   chatMessages.add(ChatMessage(
      //     text: 'Agent Response: this is a test response',
      //     isUserMessage: false,
      //   ));
      //   messageController.clear();
      // });
    }
  }

  void _onAgentDropdownChanged(String? newValue) {
    selectedAgent = newValue;
    agentID = selectedAgent=='' ? -1 : int.parse(selectedAgent!.split(":")[0]);
    viewModel.getHistory(agentID).then((history) {
        chatMessages = history;
        setState(() {
          
        });
      });
  }

    @override
  void initState() {
    
    viewModel.getAgentsNames().then((names){
      if (kDebugMode) {
        print("finished getAgentsNames");
      }
      agentsNames = names;
      if (kDebugMode) {
        print(names);
      }
      selectedAgent = agentsNames[0];
      agentID = selectedAgent=='' ? -1 : int.parse(selectedAgent!.split(":")[0]);
      if (kDebugMode) {
        print("agent id: $agentID");
      }
      setState(() {
        
      });
      viewModel.getHistory(agentID).then((history) {
          chatMessages = history;
          setState(() {
            
          });
        });

    });
    
    super.initState();
    // Appelez une fonction asynchrone pour charger les données
    // files = loadFilesData();
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
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 7,
                        style: const TextStyle(color: Colors.white),
                        controller: messageController,
                        decoration: const InputDecoration(hintText: 'Type your message', hintStyle: TextStyle(color: Colors.grey,)),
                      ),  
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white,),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
                agentsNames.isNotEmpty ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                // underline: Container(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: const Divider(
                //     // height: , // Espace entre la ligne et la liste déroulante
                //     thickness: 2,
                //     color: Colors.white, // Épaisseur de la ligne
                //     // indent: 10,
                //   ),
                // ),
                isExpanded: true,
                dropdownColor: const Color.fromARGB(255, 0, 0, 36),
                value: selectedAgent,
                onChanged: _onAgentDropdownChanged,
                items: agentsNames
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.grey),),
                  );
                }).toList(),
                          ),
              ): const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      );
  }
}

class ChatBubble extends StatelessWidget {
  final String? text;
  final bool isUserMessage;

  const ChatBubble({super.key, 
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isUserMessage ? const EdgeInsets.fromLTRB(150.0, 8.0, 8.0, 8.0): const EdgeInsets.fromLTRB(8.0, 8.0, 150.0, 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}