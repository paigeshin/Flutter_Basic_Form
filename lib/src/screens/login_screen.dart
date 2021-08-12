import 'package:flutter/material.dart';
import 'package:login_stateful/src/mixins/validate_email.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  // Create form key
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        //Pass it to children widgets
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      validator: validateEmail,
      onSaved: (String? value) {
        if (value != null) {
          email = value;
        }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Enter Password',
        hintText: 'password',
      ),
      validator: validatePasword,
      onSaved: (String? value) {
        if (value != null) {
          password = value;
        }
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        //Access form key created by its parent widget
        if (formKey.currentState != null && formKey.currentState!.validate()) {
          formKey.currentState?.save();

          // Take *both* email and password
          // add post them to some API
          print('Time to post $email and $password to my API');
        }
      },
    );
  }
}
