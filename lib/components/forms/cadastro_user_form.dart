import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appnutricao/db/users_database.dart';
import '../../themes/theme.dart';
import 'imagepicker/image_picker.dart';

class CadastroUserForm extends StatefulWidget {
  const CadastroUserForm({super.key, required this.argument});
  final String argument;

  @override
  State<CadastroUserForm> createState() => _CadastroUserFormState();
}

var listEmails = [];

class _CadastroUserFormState extends State<CadastroUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime dataSelecionada = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  Future<void> createUser(String name, String email, String password,
      String imagePath, int birthDate) async {
    await SQLHelperUsers.createItem(
        name, email, password, imagePath, birthDate, 0);
  }

  Future<void> getItems() async {
    List<Map<String, dynamic>> items = await SQLHelperUsers.getItems();
    List<dynamic> emails = [];
    for (var item in items) {
      emails.add(item['email']);
    }
    setState(() {
      listEmails = emails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const MyImagePicker(),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _nameController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o seu nome';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: colorsTwo.colorScheme.secondary),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o seu email';
                } else if (!value.contains('@')) {
                  return 'Insira um email válido';
                } else if (listEmails.contains(value)) {
                  return 'Email já cadastrado, insira outro email';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: colorsTwo.colorScheme.secondary),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: !_passwordVisible,
              controller: _passwordController,
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
                    borderSide:
                        BorderSide(color: colorsTwo.colorScheme.secondary),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data de Nascimento:\n\n${DateFormat('dd/MM/yyyy').format(dataSelecionada)}',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1930),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: colorsTwo.colorScheme,
                              ),
                              child: child!,
                            );
                          });
                      if (newDate == null) return;

                      setState(() => dataSelecionada = newDate);
                    },
                    child: Text('Data de nascimento',
                        style: TextStyle(
                            color: colorsTwo.colorScheme.secondary,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedImage == null) {
                      _formKey.currentState!.validate();
                      String imageNull = 'Insira uma imagem\n';
                      if (selectedImage == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(imageNull)));
                        return;
                      }
                    }
                    if (_formKey.currentState!.validate()) {
                      createUser(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          selectedImage!.path,
                          dataSelecionada.millisecondsSinceEpoch.abs());
                      Navigator.pushReplacementNamed(
                          context, '/cadastroUpdated',
                          arguments: widget.argument);
                      setState(() {
                        selectedImage = null;
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          colorsOne.colorScheme.secondary)),
                  child: const Text('Cadastrar'),
                ),
              ],
            )
          ],
        ));
  }
}
