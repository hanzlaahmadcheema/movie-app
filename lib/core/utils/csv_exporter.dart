import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'csv_downloader_stub.dart'
    if (dart.library.html) 'csv_downloader_web.dart';

class CsvExporter {
  CsvExporter._();

  static void exportUsers({
    required BuildContext context,
    required List<Map<String, dynamic>> userRecords,
  }) {
    final buffer = StringBuffer();
    // CSV Header
    buffer.writeln(
      'UID,Display Name,Email,Email Verified,Subscribed (Payment Verified),Role,Status,Created At,Last Login At',
    );

    for (final user in userRecords) {
      final uid = _escapeCsv(user['uid'] ?? '');
      final name = _escapeCsv(user['displayName'] ?? 'N/A');
      final email = _escapeCsv(user['email'] ?? 'N/A');
      final emailVerified = user['emailVerified'] == true ? 'Yes' : 'No';
      final paymentVerified = user['paymentVerified'] == true ? 'Yes (Subscribed)' : 'No';
      final role = _escapeCsv(user['role'] ?? 'user');
      final status = _escapeCsv(user['status'] ?? 'active');
      final createdAt = _escapeCsv(user['createdAt'] ?? '');
      final lastLoginAt = _escapeCsv(user['lastLoginAt'] ?? '');

      buffer.writeln(
        '"$uid","$name","$email","$emailVerified","$paymentVerified","$role","$status","$createdAt","$lastLoginAt"',
      );
    }

    final csvContent = buffer.toString();
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    final filename = 'ha_movieapp_users_$todayStr.csv';

    if (kIsWeb) {
      saveCsvFile(filename, csvContent);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exported ${userRecords.length} users to "$filename"'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      Clipboard.setData(ClipboardData(text: csvContent));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${userRecords.length} users. CSV copied to clipboard!',
          ),
          backgroundColor: Colors.blue.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static String _escapeCsv(dynamic val) {
    if (val == null) return '';
    return val.toString().replaceAll('"', '""');
  }
}
