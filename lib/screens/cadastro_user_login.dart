import 'package:appnutricao/components/forms/cadastro_user_form.dart';
import 'package:flutter/material.dart';
import '../themes/theme.dart';

class CadastroUserLogin extends StatefulWidget {
  const CadastroUserLogin({super.key});

  @override
  State<CadastroUserLogin> createState() => _CadastroUserLoginState();
}

class _CadastroUserLoginState extends State<CadastroUserLogin> {
  

  @override
  Widget build(BuildContext context) {
    return
        // BackGround
      Scaffold(
        appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacementNamed(context, '/login');
        },),
        backgroundColor: colorsTwo.colorScheme.secondary,
        title: const Text('Criar Usuário', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height * 0.872,
          ),
          child: const Card(
            child: Padding(
              padding:  EdgeInsets.all(15),
              child: CadastroUserForm(argument: 'login',)
                  ),
            ),
          ),
        ),
      backgroundColor: colorsOne.colorScheme.primary,
    );
  }
}
