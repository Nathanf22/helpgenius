import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;

  const CustomButton1({super.key, 
    required this.text,
    this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 30),
          backgroundColor: Colors.green, // Couleur d'arrière-plan verte
          // padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Ajustez le rayon des coins du bouton ici
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (iconData != null)
              Icon(iconData, color: Colors.white), // Icône facultative
            if (iconData != null) const SizedBox(width: 8.0), // Espacement entre l'icône et le texte
            Text(
              text,
              style: const TextStyle(
                color: Colors.white, // Couleur du texte
              ),
            ),
          ],
        ),
      ),
    );
  }
}