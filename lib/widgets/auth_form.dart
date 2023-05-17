import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex2/screen/home_screen.dart';
import '../auth.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final bool _islogin = true;
  bool _loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailCT = TextEditingController();
  final passwordCT = TextEditingController();
  Future signIn() async {
    final email = emailCT.value.text;
    final password = passwordCT.value.text;
    if (_islogin) {
      await auth().signInWithEmailAndPassword(email, password);
    } else {
      await auth().registerWithEmailAndPassword(email, password);
    }
  }

  @override
  void dispose() {
    emailCT.dispose();
    passwordCT.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: emailCT,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                  ),
                  TextFormField(
                    controller: passwordCT,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: signIn,
                    child: const Text('Login'),
                  ),
                  TextButton(
                    child: const Text('Create new account'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
