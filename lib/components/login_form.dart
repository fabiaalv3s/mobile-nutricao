import 'package:flutter/material.dart';
import '../screens/tela_principal.dart';
import '../themes/theme.dart';
import 'package:appnutricao/db/users_database.dart' as db;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  List<Map<String, int>> myHashList = [];
  int? userToLogin = 0;

  @override
  void initState() {
    super.initState();
    getHashs();
  }

  Future<void> getHashs() async {
    List<Map<String, dynamic>> items = await db.SQLHelperUsers.getItems();
    for (var item in items) {
      Map<String, int> mapItem = {
        'id': item['id'],
        'hash': item['hashCode'],
        'logged': item['logged']
      };
      debugPrint(mapItem.toString());
      myHashList.add(mapItem);
    }
    verifyLogged();
  }

  Future<void> userLogin(int id) async {
    await db.SQLHelperUsers.userLogin(id);
  }

  bool verifyHash(int loginHash) {
    debugPrint('loginHash: ${loginHash.toString()}');
    bool result = false;
    for (var map in myHashList) {
      if (map.containsKey('id')) {
        if (map['hash'] == loginHash) {
          setState(() {
            result = true;
            userToLogin = map['id'];
          });
        }
      }
    }
    debugPrint(userToLogin.toString());
    return result;
  }

  verifyLogged() {
    for (var map in myHashList) {
      if (map.containsKey('id')) {
        if (map['logged'] == 1) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => TelaPrincipal(
                    arg: map['id']!,
                  )));
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            flex: 20,
            child: SizedBox(
              height: 5,
              child: Center(
                  child: Image.asset(    
                  'lib/images/Nature - logo.jpg',
                  fit: BoxFit.contain,
              )),
            )),
        const SizedBox(
          height: 20,
        ),
        // FORMULÁRIO
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside),
                        )),
                        
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o seu email';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    controller: passwordController,
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
                        prefixIcon: Icon(Icons.lock),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside),
                        )),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira sua senha';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: buttonsTheme.textButtonTheme.style,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/cadastroUserLogin');
                          },
                          child: const Text('Cadastre-se', selectionColor: Color.fromRGBO(13, 25, 43, 1))),
                      ElevatedButton(
                          style: buttonsTheme.elevatedButtonTheme.style,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String email = emailController.text;
                              String password = passwordController.text;
                              var loginHash =
                                  email.hashCode * password.hashCode;
                              if (verifyHash(loginHash)) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TelaPrincipal(
                                              arg: userToLogin!,
                                            )));
                                userLogin(userToLogin!);
                              } else {
                                SnackBar snackbar = const SnackBar(
                                  content: Text(
                                      'Usuário não encontrado. Tente Novamente.'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            }
                          },
                          child: const Text('Acessar'))
                    ],
                  )
                ],
              ),
            )),
        const Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: SizedBox(
              height: 5,
            )),
      ],
    );
  }
}
