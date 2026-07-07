import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/movie_app.dart';
import 'core/local_db/sqflite_platform_init.dart';
import 'core/services/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  configureLocalDatabase();

  await dotenv.load(fileName: '.env', isOptional: true);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await AuthService.instance.initializeGoogleSignIn();
  } on UnsupportedError catch (error) {
    debugPrint('Firebase is not configured for this platform: $error');
  }
  runApp(const MovieApp());
}
