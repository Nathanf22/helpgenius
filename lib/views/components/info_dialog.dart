import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onClose;

  const InfoDialog({super.key, 
    required this.title,
    required this.message,
     this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 1, 1, 52),
      title: Text(title, style: const TextStyle(color: Colors.white),),
      content: Text(message, style: const TextStyle(color: Colors.white),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Ferme la boîte de dialogue
            if(onClose != null){onClose!();} // Exécute une action lorsque l'utilisateur ferme la boîte de dialogue
          },
          child: const Text('Close', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}