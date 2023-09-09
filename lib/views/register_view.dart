import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: const InputDecoration(hintText: "Enter you email here"),
        ),
        TextField(
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          controller: _password,
          decoration:
              const InputDecoration(hintText: "Enter you password here"),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final UserCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
              print(UserCredential);
            } on FirebaseAuthException catch (e) {
              print(e.code);
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
