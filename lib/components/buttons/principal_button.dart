import 'package:flutter/material.dart';
import '../../themes/theme.dart';
import 'package:appnutricao/db/users_database.dart' as db;

class PrincipalScreenButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget screen;
  final bool logout;
  final int? id;

  const PrincipalScreenButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.screen,
      required this.logout,
      this.id});

  @override
  Widget build(BuildContext context) {
    Future<void> navCadastro(Widget toScreen) async {
      if (logout) {
        await db.SQLHelperUsers.userLogout(id);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => toScreen,
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => toScreen,
          ),
        );
      }
    }

    return Flexible(
      fit: FlexFit.tight,
      flex: 10,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        colorsTwo.colorScheme.secondary)),
                onPressed: () => {navCadastro(screen)},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: Icon(
                  icon,
                  size: 75,
                ),
                onPressed: () => navCadastro(screen),
                color: Colors.white,
              ),
            )
          ],
        )
      ]),
    );
  }
}
