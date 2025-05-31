import 'package:flutter/material.dart';
import '../models/contact.dart';  


class ContactProfileScreen extends StatelessWidget {
  final Contact contact;
  final void Function(Contact) onCall;

  const ContactProfileScreen({super.key, required this.contact, required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
        actions: const [
          Icon(Icons.edit),
          SizedBox(width: 10),
          Icon(Icons.star_border),
          SizedBox(width: 10),
          Icon(Icons.settings),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
  radius: MediaQuery.of(context).size.width * 0.2, // 30% of screen width
  backgroundImage: AssetImage(contact.imagePath),
),

            const SizedBox(height: 10),
            Center(child: Text(contact.name, style: const TextStyle(fontSize: 20, color: Colors.white))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContactAction(icon: Icons.call, label: "Call", onTap: () => onCall(contact)),
                ContactAction(icon: Icons.message, label: "Message"),
                ContactAction(icon: Icons.video_call, label: "Video"),
              ],
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.white),
              title: Text(contact.number, style: const TextStyle(color: Colors.white)),
              subtitle: const Text('Mobile', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ContactAction({super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
