import 'dart:async';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';

class CadastroCreatedScreen extends StatefulWidget {
  const CadastroCreatedScreen({super.key});

  @override
  State<CadastroCreatedScreen> createState() => _CadastroCreatedScreenState();
}

class _CadastroCreatedScreenState extends State<CadastroCreatedScreen> {
  

  @override
  void initState()
  {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    var time = const Duration(seconds: 5);
    var arg = ModalRoute.of(context)!.settings.arguments as String;
    Timer(time, () {
    if (arg == 'login'){
    Navigator.pushReplacementNamed(context, '/login');
    }
    else
    {
    Navigator.pushReplacementNamed(context, '/cadastro');
    }
    });
    return Container(
      color: colorsOne.colorScheme.primary,
      child: Card(
        margin: const EdgeInsets.fromLTRB(25, 200, 25, 200),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: colorsTwo.colorScheme.secondary,
                  child: const Icon(Icons.check, size: 70,)),
              ),
              Text('Cadastro Efetuado!', style: myTextThemes.textTheme.displayMedium, textAlign: TextAlign.center,),
              const Text('Retornando a página de cadastro...')
            ]),
          ),
        ),
      ),
    );
  }
}