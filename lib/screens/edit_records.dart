import 'package:appnutricao/components/edit%20forms/cardapio_info.dart';
import 'package:appnutricao/screens/compartilhar.dart';
import 'package:flutter/material.dart';
import 'package:appnutricao/themes/theme.dart';
import '../components/edit forms/alimento_edit.dart';
import '../components/edit forms/user_edit.dart';

// ignore: must_be_immutable
class EditRecordsScreen extends StatefulWidget {
  EditRecordsScreen(
      {super.key, required this.buttonPressed, this.alimentoEdit, required this.idRecord, this.userEdit, this.cardapioInfo});
  
  int buttonPressed;
  AlimentoRecordEdit? alimentoEdit;
  UserEdit? userEdit;
  CardapioInfo? cardapioInfo;
  int idRecord;

  @override
  State<EditRecordsScreen> createState() => _EditRecordsScreenState();
}

class _EditRecordsScreenState extends State<EditRecordsScreen> {
  @override
  Widget build(BuildContext context) {
  List<Widget?> editForms = [widget.userEdit, widget.alimentoEdit, widget.cardapioInfo];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(  
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/consulta');
          },
        ),
        backgroundColor: colorsTwo.colorScheme.secondary,
        title: const Text('Dados', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      backgroundColor: colorsOne.colorScheme.primary,
      body: (widget.buttonPressed == 2)? 
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Padding(
              padding: const EdgeInsets.all(10),
              child: editForms[widget.buttonPressed]),
            )
          ],
        ),
      )
      : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Padding(
              padding: const EdgeInsets.all(10),
              child: editForms[widget.buttonPressed]),
            ),
          )
        ],
      )
    );
  }
}
