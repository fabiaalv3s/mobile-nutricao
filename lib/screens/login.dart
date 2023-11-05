import 'package:flutter/material.dart';
import '../components/login_form.dart';
import '../themes/theme.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return
        // BackGround
        Scaffold(
      body: Column(
        children: <Widget>[
          const Flexible(
            fit: FlexFit.tight,
            flex: 15,
            child: SizedBox(
              height: 1,
            ),
          ),
          // CARD LOGIN
          Flexible(
              fit: FlexFit.tight,
              flex: 70,
              child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: colorsThree.colorScheme.primary,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  elevation: 10,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: LoginForm(),
                  ))),
          const Flexible(
              fit: FlexFit.tight,
              flex: 15,
              child: SizedBox(
                height: 1,
              )),
        ],
      ),
      backgroundColor: colorsOne.colorScheme.primary,
    );
  }
}
