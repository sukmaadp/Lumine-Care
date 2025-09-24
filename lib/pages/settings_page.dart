import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notif = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              children: [
                SwitchListTile(
                  activeThumbColor: Colors.purple,
                  title: const Text("Mode Gelap"),
                  secondary: const Icon(Icons.dark_mode, color: Colors.purple),
                  value: darkMode,
                  onChanged: (val) {
                    setState(() => darkMode = val);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  activeThumbColor: Colors.purple,
                  title: const Text("Notifikasi"),
                  secondary: const Icon(
                    Icons.notifications,
                    color: Colors.purple,
                  ),
                  value: notif,
                  onChanged: (val) {
                    setState(() => notif = val);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.purple),
                  title: const Text("Bahasa"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: const Text("Pilih Bahasa"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text("Indonesia"),
                              onTap: () => Navigator.pop(context),
                            ),
                            ListTile(
                              title: const Text("English"),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.purple),
                  title: const Text("Tentang Aplikasi"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Luminé",
                      applicationVersion: "1.0.0",
                      applicationLegalese: "© 2025 Luminé Beauty Care",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
