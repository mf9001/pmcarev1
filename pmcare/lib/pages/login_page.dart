import 'dart:convert';
import 'package:flutter/material.dart';
import '/pages/signup_page.dart';
import '/backend_services/services.dart';
import '/pages/menu_page.dart';
import '/pages/forgetpassword_page.dart';
import '/pages/menu_page_rmwf.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getText(context) async {
    print(nameController.text);
    String username = nameController.text;
    String password = passwordController.text;

    bool _validation = true;

    if (username.length < 6) {
      _validation = false;
    }

    if (password.length < 6) {
      _validation = false;
    }

    var data;

    if (_validation) {
      try {
        var response = await http
            .get(Uri.http('10.0.2.2:5000', 'auth/uauth/$username/$password'));

        data = response.body;
      } catch (e) {
        print("eerrrrror  " + e.toString());
      }

      print('jsonData' + data.toString());

      if (data == 'PNT') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      }

      if (data == 'MWF') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MwfMenuPage()),
        );
      }

      if (data == 'NOOK') {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                    title: const Text("Incorrect Info"),
                    content: const Text('Could not find a match !'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("OK"),
                        ),
                      ),
                    ]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 167, 233, 226),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 100),
              _header(context),
              SizedBox(
                height: 200,
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/login_image.png',
                      height: 60,
                    )),
              ),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          )),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 54, 51, 51),
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Enter your credential to login..",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 54, 51, 51),
          ),
        ),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email address to proceed';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Color.fromARGB(255, 235, 238, 238),
                filled: true,
                prefixIcon: const Icon(Icons.email)),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Please enter password to proceed';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Color.fromARGB(255, 235, 238, 238),
              filled: true,
              prefixIcon: const Icon(Icons.password),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await getText(context);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Color.fromARGB(255, 87, 176, 182),
            ),
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 54, 51, 51)),
            ),
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
        );
      },
      child: const Text(
        "Forgot password? Reset it !",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                  color: Color.fromARGB(255, 41, 37, 228),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
