import 'dart:convert';

import 'package:currency_exchange_app/data/local/auth_service.dart';
import 'package:currency_exchange_app/data/local/local_data_source.dart';
import 'package:currency_exchange_app/data/models/user_model.dart';
import 'package:currency_exchange_app/ui/pages/main_page.dart';
import 'package:currency_exchange_app/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      // backgroundColor: Colors.transparent,
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  final local = LocalDataSource();
  final authService = AuthService();
  bool _isLoading = false;
  // final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Future<List<User>> _usersFuture;
  String message = '';

  Future<List<User>> loadUsers() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/users.json');
      final jsonMap = json.decode(jsonString);

      if (jsonMap['data'] != null) {
        final List<dynamic> data = jsonMap['data'];
        return data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        throw Exception("Missing or empty 'data' in JSON");
      }
    } catch (e) {
      throw Exception('Error loading users data: $e');
    }
  }

  void _navigateToMainPage() {
    local.saveLoginStatus();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const MainPage()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      List<User> users = await _usersFuture;
      User matchingUser = users.firstWhere(
        (user) =>
            user.email == enteredEmail && user.password == enteredPassword,
        orElse: () => User(name: '', email: "", password: ""),
      );

      authService.saveUser(matchingUser);
      if (matchingUser.email.isNotEmpty) {
        _navigateToMainPage();
        setState(() {
          message = 'Login successful! Welcome, ${matchingUser.name}';
        });
      } else {
        setState(() {
          message = 'Invalid email or password.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error loading users data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !isVisible,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: kPasswordText,
                              hintStyle: TextStyle(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password can't be empty";
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: isVisible
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                          )
                        ],
                      ),
                      // SizedBox(),
                    ],
                  ),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _usersFuture = loadUsers();
                          _login();
                          if (message.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          }
                        }
                      },
                      child: Text(kLoginButtonText)),
                ],
              ),
            ),
          );
  }
}
