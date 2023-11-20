import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Color? color;

  const CustomButton2({super.key, 
    required this.text,
    this.iconData,
    required this.onPressed, 
    this.color,  
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(150, 30),
          side: BorderSide(
            color: color ?? Colors.green, // Couleur de la bordure verte
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Ajustez le rayon des coins du bouton ici
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (iconData != null)
              Icon(iconData, color: color ?? Colors.green), // Icône facultative
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