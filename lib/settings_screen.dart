import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/theme/theme_provider.dart'; // Ensure this import is correct

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: themeProvider.themeData.brightness == Brightness.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Notifications'),
              trailing: Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: false, // Replace with actual notification preference
                  onChanged: (value) {
                    // Handle notifications toggle
                  },
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('About'),
              onTap: () {
                _showAboutDialog(context);
                // Show about dialog or navigate to an about page
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                // Navigate to privacy policy page or show dialog
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Todo List App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.monetization_on),
      children: [
        const Text(
          'This app allows users to manage their tasks efficiently, offering features like task prioritization, theme switching, and real-time task updates.',
        ),
      ],
    );
  }