import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:requests/requests.dart';
import 'global_params.dart';

class MessageModel{
    Future<ChatMessage> sendMessage(int agentID, String userID, String message) async{
    try {
      dynamic response = await Requests.post("$baseUrl/agents/$agentID/message", body: {"message": message, "user_id": userID});
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200){    
          return  ChatMessage(text: jsonResponse['response'], isUserMessage: false) ;
        }
        else{
          if (kDebugMode) {
            print("erreur lors de l'envoie du message : ${jsonResponse['message']}");
          }
          return ChatMessage(text: "", isUserMessage: false);
        }
    }
    catch (e){
      if (kDebugMode) {
        print("erreur lors de l'envoie du message: $e");
      }
      return ChatMessage(text: "", isUserMessage: false);
    }
  }


  Future<List<ChatMessage>> getHistory(int agentID, String userID) async{
  try{
    dynamic response = await Requests.get("$baseUrl/agents/$agentID/history_message/$userID");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200){
      List<dynamic> history = jsonResponse['history'];
      List<ChatMessage> historyChat = []; 
      for(var element in history){
        historyChat.add(ChatMessage(text: element['message'], isUserMessage: true));
        historyChat.add(ChatMessage(text: element['response'], isUserMessage: false));
      }
      return historyChat;
    }
    else{
      if (kDebugMode) {
        print("erreur lors de la recuperation de l'historique: ${jsonResponse['message']}");
      }
      return [];
    }
    
    
  }
  catch(e){
    if (kDebugMode) {
      print("erreur lors de la recuperation de l'historique: $e");
    }
    return [];
  }
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