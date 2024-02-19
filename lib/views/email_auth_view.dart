import 'package:flutter/material.dart';
import 'package:helpgenius/model/global_params.dart';
import 'package:helpgenius/services/snackbar.dart';
import 'package:helpgenius/viewsModel/email_auth_view_model.dart';

class EmailAuthVerificationView extends StatefulWidget {
  final VoidCallback refreshParent;
  const EmailAuthVerificationView({super.key, required this.refreshParent});
  @override
  State<EmailAuthVerificationView> createState() => _EmailAuthVerificationViewState();
}

class _EmailAuthVerificationViewState extends State<EmailAuthVerificationView> {
  final EmailAuthViewModel viewModel = EmailAuthViewModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool emailExists = false;
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    // Initialize the package
    // emailAuth.config(data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 20),
            if (emailExists)
              TextField(
                obscureText: true,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
            const SizedBox(height: 20),
            emailExists ? const Text("You are an alpha tester")
            :
            ElevatedButton(
              onPressed: ()  async{
                // Verifier si l'email existe
                userEmail = emailController.text;
                bool result = await viewModel.emailExists(userEmail);
                if(result){
                  setState(() {
                      emailExists = true;
                  });
                  
                }
                else{
                  showErrorSnackBar(context, "You are not an alpha tester: please contact admin");
                }
               
              },
              child: const Text('Check email'),
            ),
            const SizedBox(height: 20),
            if (emailExists)
              ElevatedButton(
                onPressed: () async{
                  // Vérifier le code OTP
                  String password= otpController.text;
                  userEmail = emailController.text;
                  bool result = await viewModel.passwordMatch(userEmail, password);
                  if(result){
                    authenticated = true;
                    email = userEmail;
                    widget.refreshParent();
                  }
                  else{
                    showErrorSnackBar(context, "Incorrect password, please retry");
                  }
                  
                  
                },
                child: const Text('Verify'),
              ),
          ],
        ),
      );
  }
}
