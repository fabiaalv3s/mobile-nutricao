import 'dart:io';
import 'package:appnutricao/screens/consulta.dart';
import 'package:appnutricao/screens/edit_records.dart';
import 'package:appnutricao/themes/theme.dart';
import 'package:flutter/material.dart';
import '../../db/users_database.dart';
import '../edit forms/user_edit.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});
  @override
  State<UsersList> createState() => _UsersListState();
}

List<dynamic> listaUsers = [];
bool isLoading = true;

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    super.initState();
    if (searchName == '') {
      refreshUsers();
    } else {
      searchUsersName(searchName);
    }
    debugPrint('..numero de items: ${listaUsers.length}');
  }

  Future searchUsersName(String name) async {
    setState(() => isLoading = true);
    final data = await SQLHelperUsers.getItemsByName(name);
    setState(() {
      isLoading = false;
      listaUsers = data;
    });
  }

  Future refreshUsers() async {
    final data = await SQLHelperUsers.getItems();

    setState(() {
      isLoading = false;
      listaUsers = data;
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
              (listaUsers.isEmpty)
                  ? Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 80),
                          Text(
                            'Lista vazia.\nVá para a tela de cadastros\ne cadastre novos usuários.',
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
                                itemCount: listaUsers.length,
                                itemBuilder: (context, index) {
                                  final exemplo = listaUsers[index];
                                  final Duration userAge = DateTime.now()
                                      .difference(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              exemplo['birthDate']));

                                  Image foto = Image.file(
                                    File(exemplo['imagePath']),
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
                                              const SizedBox(width: 20,),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  exemplo['name'],
                                                  style: myTextThemes
                                                      .textTheme.labelLarge,
                                                ),
                                                Text(
                                                    'Idade: ${(userAge.inDays / 365).truncate()}',
                                                    style: myTextThemes
                                                        .textTheme.labelSmall)
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20,),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditRecordsScreen(
                                                                  buttonPressed:
                                                                      buttonPressed,
                                                                  userEdit:
                                                                      UserEdit(
                                                                    idRecord:
                                                                        exemplo[
                                                                            'id'],
                                                                  ),
                                                                  idRecord:
                                                                      exemplo[
                                                                          'id'],
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
