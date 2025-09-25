import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfilePage({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white, 
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ), 
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "email": emailController.text,
                });
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
