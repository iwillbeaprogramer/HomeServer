import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/view/home_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool showWarning;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    showWarning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primary
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0,0,0,0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 2,child: Container()),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Container()),
                    Flexible(child: 
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: "E-Mail",
                                ),
                                
                              ),
                              TextField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                ),
                                obscureText: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () => loginEvent(),
                                  child: const Text("Login")
                                ),
                              ),
                              showWarning
                              ?Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.errorContainer
                                  ),
                                  child: const Text("Email 또는 Password를 확인해주세요."),
                                ),
                              )
                              :const SizedBox(height: 0,)
                            ],
                          ),
                        ),
                      )
                    ),
                    Flexible(child: Container()),
                  ],
                ),
              ),
              Flexible(flex: 2,child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  loginEvent() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty){
      Map<String, String> headers = {
        "Content-Type":"application/json",
        "Accept":"application/json",
      };
      var url = Uri.parse("http://127.0.0.1:8000/login");
      var response = await http.post(url,body: json.encode({"email":email,"password":password}),headers: headers);
      var result = json.decode(utf8.decode(response.bodyBytes));
      print(result);
      // Get.to(()=>const Home());
    } else{
      showWarning = true;
    }
    setState(() {});
  }
}