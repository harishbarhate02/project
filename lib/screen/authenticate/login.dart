import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../model/loginuser.dart';
import '../../services/auth.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  const Login({super.key, this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      // Set web-specific padding and margin
    }
    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            )));
    final txtbutton = TextButton(
      onPressed: () {

      },
      child: Text('Forgot Password?'),
    );


    final signEmailPasswordButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        child: MaterialButton(
            height: MediaQuery.of(context).size.width*.04,
            minWidth: MediaQuery.of(context).size.width*.15,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              widget.toggleView!();
            },
            child: Text(
              "Sign up",
              style: TextStyle(color: Colors.black, fontSize: 24.0),
              textAlign: TextAlign.center,
            )));

    final loginEmailPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        height: MediaQuery.of(context).size.width*.04,
        minWidth: MediaQuery.of(context).size.width*.15,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.signInEmailPassword(
                LoginUser(email: _email.text, password: _password.text));
            if (result.uid) {
              //null means unsuccessfull authentication
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
            }
          }
        },
        child: Text(
          "Log in",
          style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/image/background.jpeg'), // Replace with your image path
            fit: BoxFit.cover, // Adjust fit as needed (cover, fill, etc.)
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(
            MediaQuery.of(context).size.height * 0.1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Login to Your Account',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Text('Login using Email',
                            style: TextStyle(fontSize: 15)),
                        Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                emailField,
                                const SizedBox(height: 20),
                                passwordField,
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                        loginEmailPasswordButton,
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                    color: Colors.teal[400],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New Here?',
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      const SizedBox(height: 20),
                      const Text(
                          'Sign up and discover a great amount of new opportunities!',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 80),
                      signEmailPasswordButton,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}