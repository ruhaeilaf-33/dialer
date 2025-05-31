import 'package:flutter/material.dart';
import '../widgets/recents_manager.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recents = RecentsManager().recentCalls;

    return Scaffold(
      appBar: AppBar(title: const Text("Recent Calls")),
      body: recents.isEmpty
          ? const Center(child: Text("No recent calls."))
          : ListView.builder(
              itemCount: recents.length,
              itemBuilder: (context, index) {
                final call = recents[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage(call.imagePath)),
                  title: Text(call.name),
                  subtitle: Text(call.number),
                  trailing: Text(
                    "${call.time.hour.toString().padLeft(2, '0')}:${call.time.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
