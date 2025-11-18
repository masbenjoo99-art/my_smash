import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Import login screen
import 'db/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ kalau jalan di desktop (Linux/Windows/MacOS) → pakai sqflite_common_ffi
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    debugPrint("🔹 Database initialized with FFI for Desktop");
  } else {
    debugPrint("🔹 Database initialized with sqflite (Mobile)");
  }

  await DatabaseHelper.instance.deleteDatabase();
  debugPrint("🔹 Database berhasil direset");

  // init database & seed data bank sampah
  await DatabaseHelper.instance.database;
  await DatabaseHelper.instance.seedBankSampahIfEmpty();

  runApp(const RecycleApp());
}

class RecycleApp extends StatelessWidget {
  const RecycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recycle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins', // Set default font family
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Hanya set timer di initState, precacheImage di didChangeDependencies
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _precacheImages();
    }
  }

  Future<void> _precacheImages() async {
    try {
      await precacheImage(
        const AssetImage('assets/images/recyle.png'),
        context,
      );
      debugPrint("✅ Logo berhasil di-precache");
    } catch (e) {
      debugPrint("❌ Gagal memuat logo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAppLogo(),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth * 0.4;
        final maxHeight = constraints.maxHeight * 0.3;
        final size = maxWidth < maxHeight ? maxWidth : maxHeight;
        final finalSize = size > 200 ? 200 : size; // Max 200px

        return SizedBox(
          width: finalSize.toDouble(),
          height: finalSize.toDouble(),
          child: Image.asset(
            'assets/images/recyle.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.recycling,
              color: Colors.green,
              size: finalSize * 0.8,
            ),
          ),
        );
      },
    );
  }
}
