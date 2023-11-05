import 'package:flutter/material.dart';
import 'package:appnutricao/db/users_database.dart' as db;
import 'package:intl/intl.dart';
import '../../themes/theme.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({super.key, required this.idRecord});
  final int idRecord;

  @override
  State<UserEdit> createState() => _UserEditState();
}

bool isLoading = true;

class _UserEditState extends State<UserEdit> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<dynamic>? item;
  bool _passwordVisible = false;

  getItem() async {
    var data = await db.SQLHelperUsers.getItemByID(widget.idRecord);
    setState(() {
      item = data;
      nameController.text = item![0]['name'];
      passwordController.text = item![0]['password'];
      isLoading = false;
    });
  }

  ediItem(String nome, String password, int id) async {
    await db.SQLHelperUsers.updateItem(nome, password, id);
  }

  @override
  void initState() {
    super.initState();
    getItem();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return (isLoading)
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CARREGANDO...',
                  style: myTextThemes.textTheme.displayLarge,
                ),
              ],
            ),
          )
        : Form(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Foto, email e data de nascimento\nnão são editáveis.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Email: ${item![0]['email']}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(item![0]['birthDate']))}'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Nome do Usuário'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o nome do alimento';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorsTwo.colorScheme.secondary),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Senha'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a sua senha';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorsTwo.colorScheme.secondary),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            ediItem(nameController.text,
                                passwordController.text, widget.idRecord);

                            Navigator.pushReplacementNamed(
                                context, '/consulta');
                          },
                          style: buttonsTheme.elevatedButtonTheme.style,
                          child: const Text(
                            'Editar',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
