import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  String _userEmail = '';
  String _username = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      // use the values to send our auth request to firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('e-mail'),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Please enter a valid e-mail address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'e-mail'),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'username'),
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                    },
                    decoration: InputDecoration(labelText: 'password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'login' : 'signup'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Create new account'
                          : 'I already have an account',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
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
