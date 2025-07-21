import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  runApp(const DecryptApp());
}

Future<void> requestPermissions() async {
  await Permission.manageExternalStorage.request();
}

Future<void> decryptFolder() async {
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
    if (file is File && file.path.endsWith(".enc")) {
      try {
        final data = await file.readAsBytes();
        final iv = encrypt.IV(data.sublist(0, 16));
        final encryptedBytes = data.sublist(16);

        final decrypted = aes.decryptBytes(
          encrypt.Encrypted(encryptedBytes),
          iv: iv,
        );

        final originalFilePath = file.path.replaceAll(".enc", "");
        await File(originalFilePath).writeAsBytes(decrypted);
        await file.delete();

        print("✅ Decrypted: $originalFilePath");

        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e) {
        print("❗ Error decrypting ${file.path}: $e");
      }
    }
  }
}

class DecryptApp extends StatefulWidget {
  const DecryptApp({super.key});

  @override
  State<DecryptApp> createState() => _DecryptAppState();
}

class _DecryptAppState extends State<DecryptApp> {
  String status = "Decryption will start...";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() => status = "Decrypting...");
      await decryptFolder();
      setState(() => status = "✅ Decryption Completed!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text(status))),
    );
  }
}
