import 'package:flutter/material.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _textBodyController = TextEditingController();
  @override
  void dispose() {
    _textTitleController.dispose();
    _textBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textTitleController,
            decoration: const InputDecoration(hintText: "Title..."),
          ),
          TextField(
            controller: _textBodyController,
            decoration: const InputDecoration(hintText: "Body..."),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
