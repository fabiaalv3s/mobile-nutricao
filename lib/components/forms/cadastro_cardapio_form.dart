import 'package:flutter/material.dart';
import 'package:appnutricao/db/alimentos_database.dart' as db_alimentos;
import 'package:appnutricao/db/cardapio_database.dart' as db_cardapio;
import '../../themes/theme.dart';
import '../classes/cardapio.dart';

class CadastroCardapioForm extends StatefulWidget {
  const CadastroCardapioForm({Key? key}) : super(key: key);

  @override
  State<CadastroCardapioForm> createState() => _CadastroCardapioFormState();
}

class _CadastroCardapioFormState extends State<CadastroCardapioForm> {
  final TextEditingController _nomeController = TextEditingController();
  List<DropdownMenuItem<String>> alimentosCafe = [];
  List<DropdownMenuItem<String>> alimentosAlmoco = [];
  List<DropdownMenuItem<String>> alimentosJanta = [];
  List<String> listaAllAlimentos = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? cafe1;
  String? cafe2;
  String? cafe3;

  String? almoco1;
  String? almoco2;
  String? almoco3;
  String? almoco4;
  String? almoco5;

  String? janta1;
  String? janta2;
  String? janta3;
  String? janta4;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAlimentos();
  }

  Future<void> getAlimentos() async {
    var data = await db_alimentos.SQLHelperAlimentos.getItems();
    if (alimentosCafe.isEmpty &&
        alimentosAlmoco.isEmpty &&
        alimentosJanta.isEmpty) {
      for (var alimento in data) {
        DropdownMenuItem<String> dropDown = DropdownMenuItem(
          value: alimento['id'].toString(),
          child: Text('${alimento['nome']} - ${alimento['tipo']}'),
        );
        if (alimento['categoria'].toString() == 'Café da Manhã') {
          alimentosCafe.add(dropDown);
        } else if (alimento['categoria'].toString() == 'Almoço') {
          alimentosAlmoco.add(dropDown);
        } else if (alimento['categoria'].toString() == 'Janta') {
          alimentosJanta.add(dropDown);
        }
        listaAllAlimentos.add(alimento['nome']);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future createCardapio(Cardapio cardapio) async {
    await db_cardapio.SQLHelperCard.createItem(cardapio);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/cadastroUpdated',
        arguments: 'consulta');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nomeController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Insira o nome do Cardápio';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: 'Nome do Cardápio',
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorsTwo.colorScheme.secondary),
                )),
          ),
          const SizedBox(height: 10),
          Card(
            color: colorsOne.colorScheme.primary,
            elevation: 5,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Café da Manhã',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('1º Alimento'),
                      value: cafe1,
                      items: alimentosCafe,
                      onChanged: (val) {
                        setState(() {
                          cafe1 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('2º Alimento'),
                      value: cafe2,
                      items: alimentosCafe,
                      onChanged: (val) {
                        setState(() {
                          cafe2 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('3º Alimento'),
                      value: cafe3,
                      items: alimentosCafe,
                      onChanged: (val) {
                        setState(() {
                          cafe3 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Card(
            color: colorsOne.colorScheme.primary,
            elevation: 5,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Almoço',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('1º Alimento'),
                      value: almoco1,
                      items: alimentosAlmoco,
                      onChanged: (val) {
                        setState(() {
                          almoco1 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('2º Alimento'),
                      value: almoco2,
                      items: alimentosAlmoco,
                      onChanged: (val) {
                        setState(() {
                          almoco2 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('3º Alimento'),
                      value: almoco3,
                      items: alimentosAlmoco,
                      onChanged: (val) {
                        setState(() {
                          almoco3 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('4º Alimento'),
                      value: almoco4,
                      items: alimentosAlmoco,
                      onChanged: (val) {
                        setState(() {
                          almoco4 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('5º Alimento'),
                      value: almoco5,
                      items: alimentosAlmoco,
                      onChanged: (val) {
                        setState(() {
                          almoco5 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Card(
            color: colorsOne.colorScheme.primary,
            elevation: 5,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Jantar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('1º Alimento'),
                      value: janta1,
                      items: alimentosJanta,
                      onChanged: (val) {
                        setState(() {
                          janta1 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('2º Alimento'),
                      value: janta2,
                      items: alimentosJanta,
                      onChanged: (val) {
                        setState(() {
                          janta2 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('3º Alimento'),
                      value: janta3,
                      items: alimentosJanta,
                      onChanged: (val) {
                        setState(() {
                          janta3 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(10),
                      isExpanded: true,
                      hint: const Text('4º Alimento'),
                      value: janta4,
                      items: alimentosJanta,
                      onChanged: (val) {
                        setState(() {
                          janta4 = val;
                          isLoading = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  var cardapio = Cardapio(
                    name: _nomeController.text,
                    cafeId1: int.parse(cafe1 ?? '0'),
                    cafeId2: int.parse(cafe2 ?? '0'),
                    cafeId3: int.parse(cafe3 ?? '0'),
                    almocoId1: int.parse(almoco1 ?? '0'),
                    almocoId2: int.parse(almoco2 ?? '0'),
                    almocoId3: int.parse(almoco3 ?? '0'),
                    almocoId4: int.parse(almoco4 ?? '0'),
                    almocoId5: int.parse(almoco5 ?? '0'),
                    jantarId1: int.parse(janta1 ?? '0'),
                    jantarId2: int.parse(janta2 ?? '0'),
                    jantarId3: int.parse(janta3 ?? '0'),
                    jantarId4: int.parse(janta4 ?? '0'),
                  );
                  debugPrint(cardapio.toString());
                  
                  createCardapio(cardapio);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      colorsOne.colorScheme.secondary),
                ),
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
