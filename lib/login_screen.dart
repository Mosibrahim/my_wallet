import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_wallet/home.dart';
import 'package:my_wallet/model/user.dart';
import 'package:my_wallet/util/constants.dart';
import 'package:my_wallet/util/databaseUtils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.grey.shade100,
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(top: 300)),
                  Card(
                    child: Stack(
                      children: [
                        Container(
                          color:
                              Color((Random().nextDouble() * 0xFFFFFF).toInt()),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Username OR Email",
                          fillColor: Colors.white,
                          filled: true),
                      controller: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Password",
                          fillColor: Colors.white),
                      controller: passwordController,
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context) * .2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              child: Text(
                                "Login/register",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              onPressed: () async {
                                Random random = Random();
                                double walletAmount =
                                    random.nextDouble() * 1000;
                                double transActionAmount =
                                    random.nextDouble() * walletAmount;

                                User user = User(
                                    usernameController.text,
                                    passwordController.text,
                                    usernameController.text + '@mail.com',
                                    walletAmount,
                                    transActionAmount);
                                final ParseResponse signUpResponse =
                                    await user.signUp();
                                if (signUpResponse.success) {
                                  ParseResponse loginResponse =
                                      await user.login();
                                  if (loginResponse.success) {
                                    user.id = await DatabaseUtils.insertUser(
                                        user.toDBJson());
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(user)));
                                  }
                                  print(loginResponse.result);
                                } else {
                                  signUpResponse.error!.message;
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
