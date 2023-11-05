import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:share/share.dart';
import 'package:appnutricao/screens/consulta.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';
import '../../db/alimentos_database.dart';

class ShareAlimentosList extends StatefulWidget {
  const ShareAlimentosList({super.key});
  @override
  State<ShareAlimentosList> createState() => _ShareAlimentosListState();
}

List<dynamic> listaAlimentos = [];
bool isLoading = true;

class _ShareAlimentosListState extends State<ShareAlimentosList> {
  @override
  void initState() {
    super.initState();
    refreshAlimentos();
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
                            'Lista vazia.\nVá para a tela de cadastros\ne cadastre novos alimentos.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                            height: (MediaQuery.of(context).size.height * 0.70),
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
                                              child: ClipOval(child: foto)),
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
                                                Share.shareFiles([
                                                  exemplo['pdfPath']
                                                ], text: 'Veja esse Alimento!');
                                              },
                                              icon: const Icon(Icons.share)),
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
