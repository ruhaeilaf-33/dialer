import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../models/recent_call.dart';
import 'contact_profile_screen.dart';
import 'call_screen.dart';  // Import CallScreen here
import '../widgets/recents_manager.dart';

class ContactSelector extends StatefulWidget {
  const ContactSelector({super.key});

  @override
  State<ContactSelector> createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<ContactSelector> {
  final List<Contact> allContacts = [
    Contact(name: "Arjun", number: "+919689677410", imagePath: "assets/aa.jpg_large"),
    Contact(name: "Hermione", number: "+919777327410", imagePath: "assets/hermi.jpeg"),
    Contact(name: "Jungkook", number: "+919638275204", imagePath: "assets/jk.jpeg"),
    Contact(name: "Roopashree", number: "+919639887410", imagePath: "assets/roopa.jpeg"),
    Contact(name: "Ruha", number: "+916448527410", imagePath: "assets/ruhaa.jpeg"),
    Contact(name: "Rupali", number: "+919638527410", imagePath: "assets/rupali.jpeg"),
    Contact(name: "Sanjana", number: "+919374846746", imagePath: "assets/sanju.jpeg"),
    Contact(name: "Teju", number: "+919698764410", imagePath: "assets/teju.jpeg"),
    Contact(name: "Thanmyaeee", number: "+9195835627410", imagePath: "assets/lazy.jpeg"),
    Contact(name: "Varsha", number: "+919638209710", imagePath: "assets/vrashas.jpeg"),
  ];

  void _openContactProfile(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactProfileScreen(
          contact: contact,
          onCall: _callContact,
        ),
      ),
    );
  }

  void _callContact(Contact contact) {
    RecentsManager().addCall(
      RecentCall(
        name: contact.name,
        number: contact.number,
        imagePath: contact.imagePath,
        time: DateTime.now(),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          contact: contact,
          onCallEnd: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (context, index) {
          final contact = allContacts[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(contact.imagePath)),
            title: Text(contact.name),
            subtitle: Text(contact.number),
            onTap: () => _openContactProfile(contact),
            trailing: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () => _callContact(contact),
            ),
          );
        },
      ),
    );
  }
}
