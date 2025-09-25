import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'device_info_page.dart';
import 'shared_preferences_page.dart';
import 'feedback_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notif = true;

  @override
  void initState() {
    super.initState();
    _loadUserPrefs();
  }

  Future<void> _loadUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
      notif = prefs.getBool('notif') ?? true;
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode);
    await prefs.setBool('notif', notif);
  }

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
          // Bagian Tampilan & Notifikasi
          _buildSection(
            title: "Tampilan & Notifikasi",
            children: [
              SwitchListTile(
                activeThumbColor: Colors.purple,
                title: const Text("Mode Gelap"),
                secondary: const Icon(Icons.dark_mode, color: Colors.purple),
                value: darkMode,
                onChanged: (val) {
                  setState(() => darkMode = val);
                  _savePrefs();
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
                  _savePrefs();
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bagian Informasi Aplikasi
          _buildSection(
            title: "Informasi Aplikasi",
            children: [
              _buildListTile(
                icon: Icons.devices,
                title: "Device Info",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DeviceInfoPage()),
                ),
              ),
              _buildListTile(
                icon: Icons.storage,
                title: "Shared Preferences",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SharedPreferencesPage(),
                  ),
                ),
              ),
              _buildListTile(
                icon: Icons.feedback,
                title: "Feedback",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bagian Lainnya
          _buildSection(
            title: "Lainnya",
            children: [
              _buildListTile(
                icon: Icons.language,
                title: "Bahasa",
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
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Bahasa diatur ke Indonesia'),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: const Text("English"),
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Language set to English'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.info,
                title: "Tentang Aplikasi",
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "Luminé",
                    applicationVersion: "1.0.0",
                    applicationIcon: const Icon(
                      Icons.spa,
                      color: Colors.purple,
                    ),
                    applicationLegalese:
                        "© 2025 Luminé Beauty Care\nAll rights reserved.",
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Section Card
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  // Widget ListTile Reusable
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
