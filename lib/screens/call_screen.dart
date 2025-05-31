import 'dart:async';
import 'package:flutter/material.dart';
import '../models/contact.dart';

class CallScreen extends StatefulWidget {
  final Contact contact;
  final VoidCallback onCallEnd;

  const CallScreen({super.key, required this.contact, required this.onCallEnd});

  @override
  // ignore: library_private_types_in_public_api
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late Timer _timer;
  int _seconds = 0;

  String get _formattedTime {
    int minutes = _seconds ~/ 60;
    int secs = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildCallControl(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[800],
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
        child: Column(
          children: [
            const Spacer(),
            CircleAvatar(radius: 70, backgroundImage: AssetImage(widget.contact.imagePath)),
            const SizedBox(height: 20),
            Text(widget.contact.name, style: const TextStyle(color: Colors.white, fontSize: 26)),
            Text(widget.contact.number, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 10),
            Text(_formattedTime, style: const TextStyle(color: Colors.greenAccent, fontSize: 20)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCallControl(Icons.volume_up, "Speaker"),
                _buildCallControl(Icons.videocam, "Video"),
                _buildCallControl(Icons.bluetooth_audio, "Bluetooth"),
                _buildCallControl(Icons.dialpad, "Keypad"),
                _buildCallControl(Icons.mic_off, "Mute"),
              ],
            ),
            const Spacer(),
            IconButton(
              iconSize: 60,
              icon: const Icon(Icons.call_end),
              color: Colors.red,
              onPressed: () {
                _timer.cancel();
                widget.onCallEnd();
              },
            ),
          ],
        ),
      ),
    );
  }
}
