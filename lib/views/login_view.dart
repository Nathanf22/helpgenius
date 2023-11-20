import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Connexion'), // Titre du pop-up
      content: Column(
        mainAxisSize: MainAxisSize.min, // Pour ajuster la taille du pop-up au contenu
        children: <Widget>[
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Nom d\'utilisateur',
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true, // Pour masquer le mot de passe
            decoration: const InputDecoration(
              labelText: 'Mot de passe',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Ajoutez votre logique de connexion ici
            final username = usernameController.text;
            final password = passwordController.text;
            // Faites quelque chose avec les données de connexion (par exemple, vérification)
            print('Nom d\'utilisateur : $username, Mot de passe : $password');
            Navigator.of(context).pop(); // Ferme le pop-up
          },
          child: const Text('Connexion'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Ferme le pop-up sans effectuer de connexion
          },
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}
