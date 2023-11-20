import 'package:helpgenius/views/components/custom_button2.dart';
import 'package:flutter/material.dart';

class DeleteConfirmation extends StatelessWidget {
  final String itemName;
  final VoidCallback onConfirm;

  const DeleteConfirmation({super.key, 
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
      backgroundColor: const Color.fromARGB(255, 1, 1, 52),
      // title: const Text('Confirm Deletion'),
      content: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.7, -3),
            end: Alignment.bottomRight,
            colors: [ Color.fromARGB(230, 1, 1, 52), Color.fromARGB(255, 1, 1, 52)], // Couleurs du dégradé
          ),
        ),
        child: Text('Are you sure you want to delete "$itemName" ?',
        style: const TextStyle(color: Colors.white),
        ),
        ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Ferme la boîte de dialogue
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white),),
        ),
        CustomButton2(text: 'Delete',
        color: Colors.red, 
        onPressed:() {
            Navigator.of(context).pop(); // Ferme la boîte de dialogue
            onConfirm(); // Exécute l'action de suppression
          }),
      ],
    );
  }
}
