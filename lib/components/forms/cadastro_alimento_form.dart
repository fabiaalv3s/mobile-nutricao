
import 'package:flutter/material.dart';
import '../../db/alimentos_database.dart';
import '../../themes/theme.dart';
import '../classes/alimento.dart';
import 'imagepicker/image_picker.dart';
import '../mobile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CadastroAlimentoForm extends StatefulWidget {
  const CadastroAlimentoForm({super.key});

  @override
  State<CadastroAlimentoForm> createState() => _CadastroAlimentoFormState();
}

String? categoriaRefeicao;
String? tipoAlimento;
Alimento? alimentoCadastrado;

class _CadastroAlimentoFormState extends State<CadastroAlimentoForm> {
  final TextEditingController _nomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      categoriaRefeicao = null;
      tipoAlimento = null;
    });
  }

  Future<void> _createPDF(
      String nome, String imgPath, String categoria, String tipo) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('''
        Nome do Alimento: $nome,\n
        Categoria: $categoria,\n
        Tipo: $tipo
    ''',
        PdfStandardFont(PdfFontFamily.helvetica, 20));

    List<int> bytes = await document.save();
  
    document.dispose();

    var caminho = await saveFile(bytes, 'Alimento - ${DateTime.now()}.pdf');

    createAlimento(nome, imgPath, categoria, tipo, caminho.toString());
    debugPrint('Objeto Criado');
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/cadastroUpdated',
        arguments: 'consulta');
    setState(() {
      selectedImage = null;
    });
  }

  Future<void> createAlimento(String nome, String fotoBytes, String categoria,
      String tipo, String pdfPath) async {
    await SQLHelperAlimentos.createItem(Alimento(
        nome: nome,
        fotoBytes: fotoBytes,
        categoria: categoria,
        tipo: tipo,
        pdfPath: pdfPath));
    debugPrint('cadastrado!');
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
              controller: _nomeController,
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
              height: 10,
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
                      hint: const Text('Categoria da Refeição'),
                      value: categoriaRefeicao,
                      items: const [
                        DropdownMenuItem(
                            value: 'Café da Manhã',
                            child: Text('Café da Manhã')),
                        DropdownMenuItem(
                            value: 'Almoço', child: Text('Almoço')),
                        DropdownMenuItem(value: 'Janta', child: Text('Janta')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          categoriaRefeicao = val.toString();
                        });
                      }),
                ),
              ),
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
                      hint: const Text('Tipo do Alimento'),
                      value: tipoAlimento,
                      items: const [
                        DropdownMenuItem(
                            value: 'Bebida', child: Text('Bebida')),
                        DropdownMenuItem(
                            value: 'Proteína', child: Text('Proteína')),
                        DropdownMenuItem(
                            value: 'Carboidrato', child: Text('Carboidrato')),
                        DropdownMenuItem(value: 'Fruta', child: Text('Fruta')),
                        DropdownMenuItem(value: 'Grão', child: Text('Grão')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          tipoAlimento = val.toString();
                        });
                      }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedImage == null ||
                        categoriaRefeicao == null ||
                        tipoAlimento == null) {
                      _formKey.currentState!.validate();
                      String imageNull = 'Insira uma imagem\n';
                      String categoriaNull =
                          'Selecione a Categoria da Refeição\n';
                      String tipoNull = 'Selecione o Tipo de Alimento\n';
                      String? mensagem = '';
                      if (selectedImage == null) {
                        setState(() {
                          mensagem = '$mensagem$imageNull';
                        });
                      }
                      if (categoriaRefeicao == null) {
                        setState(() {
                          mensagem = '$mensagem$categoriaNull';
                        });
                      }
                      if (tipoAlimento == null) {
                        setState(() {
                          mensagem = '$mensagem$tipoNull';
                        });
                      }
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(mensagem!)));
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      _createPDF(_nomeController.text, selectedImage!.path,
                          categoriaRefeicao!, tipoAlimento!);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          colorsOne.colorScheme.secondary)),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ],
        ));
  }
}
