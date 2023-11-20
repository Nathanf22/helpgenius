// import 'package:flutter/material.dart';


// ///Custom Temporory message
// class TemporaryCustomMessage extends StatelessWidget {
//   final String message;
//   final Duration duration;
//   final Color textColor; // Couleur du texte du SnackBar
//   final Color backgroundColor; // Couleur d'arrière-plan du SnackBar

//   const TemporaryCustomMessage({super.key, 
//     required this.message,
//     required this.duration,
//     required this.textColor, // Par défaut, le texte est en blanc
//     required this.backgroundColor, // Par défaut, l'arrière-plan est en bleu
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // Affiche le SnackBar lorsque le composant est créé
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 message,
//                 style: TextStyle(
//                   color: textColor, // Couleur du texte personnalisée
//                 ),
//               ),
//               backgroundColor: backgroundColor, // Couleur d'arrière-plan personnalisée
//               duration: duration,
//             ),
//           );
//         });

//         // Retourne un widget vide
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }


// ///Neutral Temporory message
// class TemporaryMessage extends StatelessWidget {
//   final String message;

//   const TemporaryMessage({super.key, 
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // Affiche le SnackBar lorsque le composant est créé
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 message,
//               ),
//             ),
//           );
//         });

//         // Retourne un widget vide
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }


// ///Sucess TemporaryMessage
// class TemporarySuccessMessage extends StatelessWidget {
//   final String message;

//   const TemporarySuccessMessage({super.key, 
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // Affiche le SnackBar lorsque le composant est créé
       
//          return showSnackBar(context
//             SnackBar(
//               content: Text(
//                 message,
//                 style:  const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.green, // Couleur d'arrière-plan personnalisée
//             ),
//           );
        

//         // Retourne un widget vide
//         // const SizedBox.shrink();
//       },
//     );
//   }
// }

// ///Error TemporaryMessage
// class TemporaryErrorMessage extends StatelessWidget {
//   final String message;

//   const TemporaryErrorMessage({super.key, 
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // Affiche le SnackBar lorsque le composant est créé
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 message,
//                 style:  const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.red, // Couleur d'arrière-plan personnalisée
//             ),
//           );
//         });

//         // Retourne un widget vide
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }



// ///Warning TemporaryMessage
// class TemporaryWarningMessage extends StatelessWidget {
//   final String message;

//   const TemporaryWarningMessage({super.key, 
//     required this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // Affiche le SnackBar lorsque le composant est créé
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 message,
//                 style:  const TextStyle(color: Colors.white),
//               ),
//               backgroundColor: Colors.orange, // Couleur d'arrière-plan personnalisée
//             ),
//           );
//         });

//         // Retourne un widget vide
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }