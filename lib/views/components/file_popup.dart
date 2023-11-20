import 'package:flutter/material.dart';

class FilePopup extends StatelessWidget {
  final VoidCallback onDownloadPressed;
  final VoidCallback onDeletePressed;

  const FilePopup({super.key, 
    required this.onDownloadPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: const Text('Actions possibles'),
      // contentPadding: EdgeInsets.zero,
      backgroundColor: const Color.fromARGB(255, 1, 1, 52),
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
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.download, color: Colors.white,),
                title: const Text('Download', 
                style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.of(context).pop(); // Ferme le popup
                  onDownloadPressed(); // Exécute l'action de téléchargement
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red,),
                title: const Text('Delete',
                style: TextStyle(color: Colors.red),),
                onTap: () {
                  Navigator.of(context).pop(); // Ferme le popup
                  onDeletePressed(); // Exécute l'action de suppression
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}