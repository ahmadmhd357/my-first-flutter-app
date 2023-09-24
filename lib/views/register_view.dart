import 'package:flutter/material.dart';
import 'package:myfirstapp/constans/routes.dart';
import 'package:myfirstapp/services/auth/auth_exceptions.dart';
import 'package:myfirstapp/services/auth/auth_service.dart';
import 'package:myfirstapp/utilites/show_error_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
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
                await AuthService.firebase()
                    .creatUser(email: email, password: password);
                if (!context.mounted) return;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email address');
              } on GenericAuthException {
                showErrorDialog(context, 'Error: Registeration error');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, (Route<dynamic> route) => false);
            },
            child: const Text('Already a member? Login here!'),
          ),
        ],
      ),
    );
  }
}
