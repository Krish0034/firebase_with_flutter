import 'package:firebase_with_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<StatefulWidget> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
