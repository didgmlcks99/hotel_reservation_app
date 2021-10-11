import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 20.0),
              // TODO: Wrap Username with AccentColorOverride (103)
              // TODO: Remove filled: true values (103)
              TextFormField(
                validator: (value) {
                  if (value == null || !validateUsername(value)) {
                    return 'Username is invalid';
                  }
                  return null;
                },
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                key: _passwordFieldKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              // TODO: Wrap Password with AccentColorOverride (103)
              TextFormField(
                validator: (value) {
                  if (value != _passwordFieldKey.currentState!.value) {
                    return 'Confirm Password doesn\'t match Password';
                  }
                  return null;
                },
                controller: _confirmController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email Address';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Email Address',
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  // TODO: Add a beveled rectangular border to CANCEL (103)
                  ElevatedButton(
                    child: const Text('SIGN UP'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()==true) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateUsername(String value) {
    int alphaCount = 0;
    int numCount = 0;

    for (int i = 0; i < value.length; i++) {
      if (int.tryParse(value[i]) != null) {
        numCount++;
      } else
      if ((value[i].codeUnitAt(0) >= 97 && value[i].codeUnitAt(0) <= 122)
          || (value[i].codeUnitAt(0) >= 65 && value[i].codeUnitAt(0) <= 90)) {
        alphaCount++;
      }
    }

    if(alphaCount >=3 && numCount >= 3){
      return true;
    }else{
      return false;
    }
  }

}