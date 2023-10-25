import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  late GetStorage getStorage;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    showWarning = false;
    getStorage = GetStorage();
    emailController.text = getStorage.read("EMAIL") ?? "";
    passwordController.text = getStorage.read("PASSWORD") ?? "";
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
              Flexible(child: Container()),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Container()),
                    Container(
                      width: 500,
                      height: 300,
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
                              onSubmitted: (value) async {
                                await loginEvent();
                              },
                            ),
                            showWarning
                            ?Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 50,                                    
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context).colorScheme.error
                                      ),
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Email 또는 Password를 확인해주세요.",
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            :const SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () => loginEvent(),
                                child: const Text("Login")
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(child: Container()),
                  ],
                ),
              ),
              Flexible(child: Container()),
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
      getStorage.write("EMAIL",email);
      getStorage.write("PASSWORD",password);
      getStorage.write("access_token",result["access_token"]);
      Get.toNamed("/home");
    } else{
      showWarning = true;
      setState(() {});
    }
    
  }
}