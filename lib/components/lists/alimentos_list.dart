import 'dart:io';

import 'package:appnutricao/screens/consulta.dart';
import 'package:appnutricao/screens/edit_records.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';
import '../../db/alimentos_database.dart';
import '../edit forms/alimento_edit.dart';

class AlimentosList extends StatefulWidget {
  const AlimentosList({super.key});
  @override
  State<AlimentosList> createState() => _AlimentosListState();
}

List<dynamic> listaAlimentos = [];
bool isLoading = true;

class _AlimentosListState extends State<AlimentosList> {
  @override
  void initState() {
    super.initState();
    if (searchName == '') {
      refreshAlimentos();
    } else {
      searchAlimentosName(searchName);
    }
    debugPrint('..numero de items: ${listaAlimentos.length}');
  }

  Future searchAlimentosName(String name) async {
    setState(() => isLoading = true);
    final data = await SQLHelperAlimentos.getItemsByName(name);
    setState(() {
      isLoading = false;
      listaAlimentos = data;
    });
  }

  Future refreshAlimentos() async {
    final data = await SQLHelperAlimentos.getItems();

    setState(() {
      isLoading = false;
      listaAlimentos = data;
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
        : Column(
            children: [
              (listaAlimentos.isEmpty)
                  ? Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 80),
                          Text(
                              'Lista vazia.\nVá para a tela de cadastros\ne cadastre novos alimentos.', textAlign: TextAlign.center,),
                        ],
                      ),
                    )
                  : Column( 
                      children: [
                        SizedBox(
                            height:
                                (MediaQuery.of(context).size.height * 0.70),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listaAlimentos.length,
                                itemBuilder: (context, index) {
                                  final exemplo = listaAlimentos[index];

                                  Image foto = Image.file(
                                    File(exemplo['fotoBytes']),
                                    fit: BoxFit.cover,
                                  );



                                  return Card(
                                    margin: const EdgeInsets.all(5),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 100,
                                                  maxWidth: 100,
                                                  minHeight: 100,
                                                  minWidth: 100),
                                              child:
                                                  ClipOval(child: foto)),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  exemplo['nome'],
                                                  style: myTextThemes
                                                      .textTheme.labelLarge,
                                                ),
                                                Text(
                                                    '${exemplo['tipo']}\n${exemplo['categoria']}',
                                                    style: myTextThemes
                                                        .textTheme.labelSmall)
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditRecordsScreen(
                                                              buttonPressed:
                                                                  buttonPressed,
                                                              alimentoEdit: AlimentoRecordEdit(idRecord: exemplo['id']),
                                                              idRecord: exemplo['id'],
                                                            )));
                                              },
                                              icon: const Icon(Icons.edit)),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
            ],
          );
  }
}
