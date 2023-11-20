import 'package:flutter/material.dart';

class IntegrationView extends StatelessWidget {
  const IntegrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
          IntegrationCard(
            title: 'Web Integration',
            description: 'Add your agent on your website',
            icon: Icons.language,
          ),
          IntegrationCard(
            title: 'Telegram',
            description: 'Create Telegram bot',
            icon: Icons.send,
          ),
          IntegrationCard(
            title: 'Facebook Messenger',
            description: 'Add your Agent to Facebook Messenger',
            icon: Icons.message,
          ),
          IntegrationCard(
            title: 'WhatsApp',
            description: 'Add your Agent to WhatsApp',
            icon: Icons.chat,
          ),
        ],
      );
    
  }
}

class IntegrationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const IntegrationCard({super.key, 
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        
      } ,
      child: Card(
        color: Colors.transparent,
        margin: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: Icon(icon, size: 28.0, color: Colors.grey,),
          title: Text(title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(description, style: const TextStyle(color: Colors.grey),),
        ),
      ),
    );
  }
}
