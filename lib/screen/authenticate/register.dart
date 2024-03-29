import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/loginuser.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({super.key, this.toggleView});


  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  final AuthService _auth = AuthService();

  bool _obscureText = true;
  final _email = TextEditingController();
  final _confirmpassword = TextEditingController();
  final _enterpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

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
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final enterPasswordField = TextFormField(
        obscureText: _obscureText,
        controller: _enterpassword,
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
            hintText: "Enter Password",
            suffixIcon: IconButton(
              icon:
              Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final confirmPasswordField = TextFormField(
        obscureText: _obscureText,
        controller: _confirmpassword,
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
            hintText: "Confirm Password",
            suffixIcon: IconButton(
              icon:
              Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));


    final loginButton = Material(
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
          "Sign In",
          style: TextStyle(color: Colors.teal[400], fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        height: MediaQuery.of(context).size.width*.04,
        minWidth: MediaQuery.of(context).size.width*.15,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {

              final snapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .get(); // Add await here
              // ...

            } catch (e) {
              // ...
            }

            dynamic result = await _auth.registerEmailPassword(
                LoginUser(email: _email.text, password: _enterpassword.text));
            if (result.uid == null) {
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
          "Register",
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
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.teal[400],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Welcome Back!', style: TextStyle(color: Colors.white, fontSize: 40)),
                      const SizedBox(height: 20),
                      const Text('To keep onnected with us please login with your personal info',

                          style: TextStyle(color: Colors.white,fontSize: 15), textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      loginButton,
                    ],
                  ),
                ),
              ),
              Expanded(
                  child:
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                      ),
                      padding : const EdgeInsets.all(20),
                      child : Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
                        child: Column (
                            mainAxisAlignment : MainAxisAlignment.center,
                            children : [
                              const Text('Register Here',
                                  style: TextStyle(
                                      fontSize: 35, fontWeight: FontWeight.bold)),
                              Center(
                                child: Container(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        emailField,
                                        const SizedBox(height: 20),
                                        enterPasswordField,
                                        const SizedBox(height: 20),
                                        confirmPasswordField,

                                      ],
                                    )),
                              ),


                              const SizedBox(height: 40),
                              registerButton,


                            ]
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

}