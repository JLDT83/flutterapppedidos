import 'package:flutter/material.dart';
import 'package:app_pedido/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_pedido/inherited/my_inherited.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://sbxwsjrzmnfvtcvjnquk.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNieHdzanJ6bW5mdnRjdmpucXVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU0MzQ0OTUsImV4cCI6MjAzMTAxMDQ5NX0.9j5O_4r0bJCSYbjKLRZVorcQ1-DjMKjC7RdiExBP9Jc');

  runApp(const MyAppPedidos());
}

class MyAppPedidos extends StatelessWidget {
  const MyAppPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    const String tituloApp = 'DAf C.A.';
    return GetInfoUser(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: tituloApp,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: HomeScreen(titulo: tituloApp,),
      ),
    );
  }
}
