import 'package:flutter/material.dart';
import '../widgets/recents_manager.dart';

class PhoneDialerScreen extends StatefulWidget {
  final void Function(String) onCall;

  const PhoneDialerScreen({super.key, required this.onCall});

  @override
  State<PhoneDialerScreen> createState() => _PhoneDialerScreenState();
}

class _PhoneDialerScreenState extends State<PhoneDialerScreen> {
  String phoneNumber = '';

  void _onKeyPressed(String value) {
    setState(() {
      phoneNumber += value;
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  void _onCallPressed() {
    if (phoneNumber.isNotEmpty) {
      widget.onCall(phoneNumber);
      RecentsManager().addRawNumber(phoneNumber); // ✅ Now correctly defined in RecentsManager
      Navigator.pop(context);
    }
  }

  Widget _buildDialButton(String digit, String? subText) {
    return GestureDetector(
      onTap: () => _onKeyPressed(digit),
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(digit, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            if (subText != null && subText.isNotEmpty)
              Text(subText, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const dialPad = [
      ['1', '', '2', 'ABC', '3', 'DEF'],
      ['4', 'GHI', '5', 'JKL', '6', 'MNO'],
      ['7', 'PQRS', '8', 'TUV', '9', 'WXYZ'],
      ['*', '', '0', '+', '#', ''],
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dialer'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 36, letterSpacing: 1.5),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDialButton(dialPad[i][0], dialPad[i][1]),
                      _buildDialButton(dialPad[i][2], dialPad[i][3]),
                      _buildDialButton(dialPad[i][4], dialPad[i][5]),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _onDeletePressed,
                      icon: const Icon(Icons.backspace),
                      iconSize: 30,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 40),
                    GestureDetector(
                      onTap: _onCallPressed,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(Icons.phone, color: Colors.white, size: 32),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
