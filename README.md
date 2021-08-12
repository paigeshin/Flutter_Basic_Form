# Keypoint of this module

- Global Key
- Mixin

# Blueprints

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a355d8df-cf96-45b9-9dc1-37f206bce24b/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3bcba577-6b90-496b-a2a7-fb896c3663e5/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ae17f899-7569-4686-8d32-8f9f6d305eea/Untitled.png)

# Create Global Key and pass it to children widgets

```dart
class LoginScreenState extends State<LoginScreen> {
  // Create form key
  final formKey = GlobalKey<FormState>();
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
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Enter Password',
        hintText: 'password',
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {},
    );
  }
}
```

# Access form key and add validator

```dart
Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        //Access form key
        formKey.currentState?.reset();
      },
    );
  }
```

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  // Create form key
  final formKey = GlobalKey<FormState>();
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
      validator: (String? value) {
        // return null if valid
        // otherwise string (with the error mmessage) if invalid
        if (value != null && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
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
      validator: (String? value) {
        // return null if valid
        // otherwise string (with the error mmessage) if invalid
        if (value != null && value.length < 4) {
          return 'Password must be at least 4 characters';
        }
        return null;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit'),
      onPressed: () {
        //Access form key created by its parent widget
        formKey.currentState?.validate();
        // formKey.currentState?.reset();
      },
    );
  }
}
```

# Retrieving form values

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
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
      validator: (String? value) {
        // return null if valid
        // otherwise string (with the error mmessage) if invalid
        if (value != null && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
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
      validator: (String? value) {
        // return null if valid
        // otherwise string (with the error mmessage) if invalid
        if (value != null && value.length < 4) {
          return 'Password must be at least 4 characters';
        }
        return null;
      },
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
```

# Essential Objects & Methods

- `final formKey = GlobalKey<FormState>();`
- textfield property, `validator: (String? value) {}`
- textfield property, `onSaved: (String? value) {}`
- formKey.currentState.reset()
- formKey.currentState.validate()
- formkey.currentState.save()

# Mixin Introduction

- Improve reusability

```dart
mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value != null && !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePasword(String? value) {
    if (value != null && value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
```

```dart
class LoginScreenState extends State<LoginScreen> with ValidationMixin {}
```

```dart
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
```