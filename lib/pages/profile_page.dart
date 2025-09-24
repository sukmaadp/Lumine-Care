import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  const ProfilePage({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.purple,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(email, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 30),

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profil"),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditProfilePage(currentName: name, currentEmail: email),
                ),
              );
              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profil diperbarui: $result")),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Ubah Password"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text("Keluar", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
