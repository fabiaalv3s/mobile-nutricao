
import 'package:flutter/material.dart';
import 'package:appnutricao/db/alimentos_database.dart' as db;

import '../../themes/theme.dart';

class AlimentoRecordEdit extends StatefulWidget {
  const AlimentoRecordEdit({super.key, required this.idRecord});
  final int idRecord;

  @override
  State<AlimentoRecordEdit> createState() => _AlimentoRecordEditState();
}

bool isLoading = true;

class _AlimentoRecordEditState extends State<AlimentoRecordEdit> {
  TextEditingController nameController = TextEditingController();
  String? categoriaRefeicao;
  String? tipoAlimento;

  @override
  void initState() {
    super.initState();
    getItem();
    setState(() {
      isLoading = true;
    });
  }

  List<dynamic>? item;
  getItem() async {
    var data = await db.SQLHelperAlimentos.getItemByID(widget.idRecord);
    setState(() {
      item = data;
      nameController.text = item![0]['nome'];
      isLoading = false;
    });
  }

  ediItem(String nome, String categoria, String tipo,
      int id) async {
    await db.SQLHelperAlimentos.updateItem(
        nome, categoria, tipo, id);
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: Card(
                child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Carregando'),
          )))
        : Form(
            child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Fotos não são editáveis'),
                const SizedBox(
                  height: 60,
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
                      hintText: 'Nome do Alimento',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: colorsTwo.colorScheme.secondary),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          hint: Text(item![0]['categoria']),
                          value: categoriaRefeicao,
                          items: const [
                            DropdownMenuItem(
                                value: 'Café da Manhã',
                                child: Text('Café da Manhã')),
                            DropdownMenuItem(
                                value: 'Almoço', child: Text('Almoço')),
                            DropdownMenuItem(
                                value: 'Janta', child: Text('Janta')),
                          ],
                          onChanged: (val) {
                            setState(() {
                              categoriaRefeicao = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          hint: Text(item![0]['tipo']),
                          value: tipoAlimento,
                          items: const [
                            DropdownMenuItem(
                                value: 'Bebida', child: Text('Bebida')),
                            DropdownMenuItem(
                                value: 'Proteína', child: Text('Proteína')),
                            DropdownMenuItem(
                                value: 'Carboidrato',
                                child: Text('Carboidrato')),
                            DropdownMenuItem(
                                value: 'Fruta', child: Text('Fruta')),
                            DropdownMenuItem(
                                value: 'Grão', child: Text('Grão')),
                          ],
                          onChanged: (val) {
                            setState(() {
                              tipoAlimento = val.toString();
                            });
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          categoriaRefeicao ??= item![0]['categoria']; 
                          tipoAlimento ??= item![0]['tipo']; 

                          ediItem(
                            nameController.text,
                            categoriaRefeicao!,
                            tipoAlimento!,
                            widget.idRecord);

                            Navigator.pushReplacementNamed(context, '/consulta');
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
          ));
  }
}
