import 'package:appnutricao/screens/cadastro.dart';
import 'package:appnutricao/screens/cadastro_created.dart';
import 'package:appnutricao/screens/cadastro_user_login.dart';
import 'package:appnutricao/screens/consulta.dart';
import 'package:appnutricao/screens/login.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized;  
  runApp(const NutricaoApp());
}

class NutricaoApp extends StatefulWidget {
  const NutricaoApp({super.key});

  @override
  State<NutricaoApp> createState() => _NutricaoAppState();
}

class _NutricaoAppState extends State<NutricaoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/login' : (context) => const LoginScreen(),
        '/consulta' : (context) => const ConsultaScreen(),
        '/cadastro' : (context) => const CadastroScreen(),
        '/cadastroUpdated' : (context) => const CadastroCreatedScreen(),
        '/cadastroUserLogin': (context) => const CadastroUserLogin()
      },
    );
  }
} 