import 'package:appnutricao/screens/compartilhar.dart';
import 'package:appnutricao/screens/consulta.dart';
import 'package:appnutricao/screens/creditos.dart';
import 'package:appnutricao/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:appnutricao/db/users_database.dart' as db;
import '../components/buttons/principal_button.dart';
import '../themes/theme.dart';
import 'cadastro.dart';

// ignore: must_be_immutable
class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({super.key, required this.arg});
  int arg;
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

List<Map<String, dynamic>> user = [];
bool isLoading = true;

class _TelaPrincipalState extends State<TelaPrincipal> {

  @override
  void initState() {
    super.initState();
    getUser(widget.arg);
  }

  getUser(int id) async {
    var thisUser =  await db.SQLHelperUsers.getItemByID(id);
    setState(() {
      user = thisUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorsTwo.colorScheme.secondary,
        title: (isLoading)? const Text('Carregando...') : Text('Olá, ${user[0]['name']}!', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.fromLTRB(25, 20, 25, 20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    const PrincipalScreenButton(
                      icon: Icons.app_registration,
                      label: 'Cadastro',
                      screen: CadastroScreen(),
                      logout: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const PrincipalScreenButton(
                      icon: Icons.search,
                      label: 'Consulta',
                      screen: ConsultaScreen(),
                      logout: false,
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    const PrincipalScreenButton(
                      icon: Icons.share,
                      label: 'Compartilhar',
                      screen: CompartilharScreen(),
                      logout: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const PrincipalScreenButton(
                      icon: Icons.emoji_events,
                      label: 'Créditos',
                      screen: CreditosScreen(),
                      logout: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrincipalScreenButton(
                      icon: Icons.logout,
                      label: 'Logout',
                      screen: const LoginScreen(),
                      logout: true,
                      id: (isLoading)? 0 : user[0]['id'],
                    ),
                  ]),
            ),
          ),
        ),
      ]),
      backgroundColor: colorsOne.colorScheme.primary,
    );
  }
}
