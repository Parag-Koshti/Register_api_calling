import 'package:flutter/material.dart';
import 'package:igenerate_16/API/register_provider.dart';
import 'package:igenerate_16/register.dart';
import 'package:provider/provider.dart';

import 'API/login_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
        ChangeNotifierProvider(create: (ctx) => LoginProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterScreen(),
      ),
    );
  }
}
