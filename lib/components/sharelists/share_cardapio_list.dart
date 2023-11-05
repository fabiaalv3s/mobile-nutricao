import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:appnutricao/components/classes/cardapio.dart';
import 'package:appnutricao/db/cardapio_database.dart';
import 'package:share/share.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../db/alimentos_database.dart';
import '../mobile.dart';

class ShareCardapioList extends StatefulWidget {
  const ShareCardapioList({super.key});
  @override
  State<ShareCardapioList> createState() => _ShareCardapioListState();
}

List<dynamic> listaCardapio = [];
bool isLoading = true;

class _ShareCardapioListState extends State<ShareCardapioList> {
  @override
  void initState() {
    super.initState();
    refreshCardapio();

    debugPrint('..numero de items: ${listaCardapio.length}');
  }

  Future refreshCardapio() async {
    final data = await SQLHelperCard.getItems();

    setState(() {
      isLoading = false;
      listaCardapio = data;
    });
  }

  Future<void> _createPDF(int id) async {
    List<String> alimentosDesc = [];
    var dataCardapio = await SQLHelperCard.getItemByID(id);
    var cardapioAnalise = Cardapio.fromJson(dataCardapio[0]);
    var idsCardapio = dataCardapio[0].values.toList();
    idsCardapio.removeAt(0);
    idsCardapio.removeAt(0);

    for (var index in idsCardapio) {
  List<Map<String, dynamic>> dataAlimentos = await SQLHelperAlimentos.getItemByID(index);
  
  if (dataAlimentos != null && dataAlimentos.isNotEmpty) {
    Map<String, dynamic> alimentoAnalise = dataAlimentos[0];
    
    // Verifique se 'nome' e 'tipo' não são nulos antes de acessá-los
    String nomeAlimento = alimentoAnalise['nome'] ?? 'Nome não disponível';
    String tipoAlimento = alimentoAnalise['tipo'] ?? 'Tipo não disponível';
    
    String descAlimento = 'Nome do Alimento: $nomeAlimento\nTipo: $tipoAlimento';
    alimentosDesc.add(descAlimento);
  } else {
    // Trate o caso em que dataAlimentos está vazio ou nulo.
    // Por exemplo, adicione uma descrição padrão para alimentos ausentes.
    alimentosDesc.add("");
  }
}


    PdfDocument document = PdfDocument();
    var page = document.pages.add();
    // Título - Nome do Cardápio
    page.graphics.drawString('Nome do Cardápio:\n${cardapioAnalise.name}',
        PdfStandardFont(PdfFontFamily.helvetica, 40));
    // Café da manhã
    page.graphics.drawString(
        '\n\n\nCafé da Manhã', PdfStandardFont(PdfFontFamily.helvetica, 30));
    page.graphics.drawString(
        '\n\n\n\n\n\n\n${alimentosDesc[0]}\n\n${alimentosDesc[1]}\n\n${alimentosDesc[2]}\n\n',
        PdfStandardFont(PdfFontFamily.helvetica, 20));
    // Almoço
    page = document.pages.add();
    page.graphics
        .drawString('\nAlmoço', PdfStandardFont(PdfFontFamily.helvetica, 30));
    page.graphics.drawString('\n\n\n\n${alimentosDesc[3]}\n\n${alimentosDesc[4]}\n\n${alimentosDesc[5]}\n\n${alimentosDesc[6]}\n\n${alimentosDesc[7]}', PdfStandardFont(PdfFontFamily.helvetica, 20));
    //Janta
    page = document.pages.add();
    page.graphics
        .drawString('\nJanta', PdfStandardFont(PdfFontFamily.helvetica, 30));
    page.graphics.drawString('\n\n\n\n${alimentosDesc[8]}\n\n${alimentosDesc[9]}\n\n${alimentosDesc[10]}\n\n${alimentosDesc[11]}', PdfStandardFont(PdfFontFamily.helvetica, 20));

    List<int> bytes = await document.save(); // Aguarde a conclusão do Future
document.dispose();

    String pathString = 'Cardápio - ${DateTime.now().hashCode}.pdf';
    var caminho = await saveFile(bytes, pathString);

    Share.shareFiles([caminho], text: 'Veja esse Cardápio!');
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
              (listaCardapio.isEmpty)
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
                                itemCount: listaCardapio.length,
                                itemBuilder: (context, index) {
                                  final exemplo = listaCardapio[index];

                                  return Card(
                                    margin: const EdgeInsets.all(5),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Nome do cardápio:'),
                                                Text(
                                                  exemplo['name'],
                                                  style: myTextThemes
                                                      .textTheme.displayLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                _createPDF(exemplo['id']);
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
