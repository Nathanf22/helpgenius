import 'package:helpgenius/model/auth_model.dart';

class EmailAuthViewModel{
  Future<bool> emailExists(String email) async{
    return await AuthModel().checkEmail(email);
  }

  Future<bool> passwordMatch(String email, String password) async{
    return await AuthModel().checkEmailPassword(email, password);
  }
}