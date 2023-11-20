import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage, textAlign: TextAlign.center,),
    backgroundColor: Colors.red,// Couleur d'arrière-plan
    behavior: SnackBarBehavior.floating, // Comportement de SnackBar flottant
    margin: const EdgeInsets.all(16.0), // Marge autour du SnackBar
    padding: const EdgeInsets.all(16.0), // Rembourrage à l'intérieur du SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
    ),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, textAlign: TextAlign.center,), 
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating, // Comportement de SnackBar flottant
    margin: const EdgeInsets.all(16.0), // Marge autour du SnackBar
    padding: const EdgeInsets.all(16.0), // Rembourrage à l'intérieur du SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
    ),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showWarningSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, textAlign: TextAlign.center,), 
    backgroundColor: const Color.fromARGB(255, 170, 102, 0),
    behavior: SnackBarBehavior.floating, // Comportement de SnackBar flottant
    margin: const EdgeInsets.all(16.0), // Marge autour du SnackBar
    padding: const EdgeInsets.all(16.0), // Rembourrage à l'intérieur du SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
    ),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message, textAlign: TextAlign.center,), 
    backgroundColor: Colors.grey,
    behavior: SnackBarBehavior.floating, // Comportement de SnackBar flottant
    margin: const EdgeInsets.all(16.0), // Marge autour du SnackBar
    padding: const EdgeInsets.all(16.0), // Rembourrage à l'intérieur du SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
    ),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}