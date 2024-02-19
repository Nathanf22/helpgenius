
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:helpgenius/model/global_params.dart';
import 'package:requests/requests.dart';

class AuthModel{
  Future<bool> checkEmail(email) async{
    try {
      dynamic response = await Requests.get("$baseUrl/alphaTester/emailExists/$email");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          bool emailExists = jsonResponse['exists'];
          return emailExists;
        }
        else{
          return false;
        }
    }
    catch (e){
      if (kDebugMode) {
        print("erreur lors de la verification de l'email: $e");
      }
      return false;
    }
  }

  Future<bool> checkEmailPassword(email, password) async{
    try {
      dynamic response = await Requests.get("$baseUrl/alphaTester/$email/$password");
        if (response.statusCode == 200){
          Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          bool passwordMatch = jsonResponse['password_match'];
          return passwordMatch;
        }
        else{
          return false;
        }
    }
    catch (e){
      if (kDebugMode) {
        print("erreur lors de la verification du password: $e");
      }
      return false;
    }
  }
}