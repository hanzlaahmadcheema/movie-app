import 'package:flutter/material.dart';

class TvNotificationsScreen extends StatelessWidget {
  const TvNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off, size: 100, color: Colors.white54),
            SizedBox(height: 24),
            Text(
              'No notifications',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
