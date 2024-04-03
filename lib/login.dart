import 'package:flutter/material.dart';

import 'package:igenerate_16/custome_widget/widget.dart';
import 'package:provider/provider.dart';

import 'API/login_provider.dart';
import 'API/login_provider.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  FocusNode EmailFocus = FocusNode();
  FocusNode PassFocus = FocusNode();
  final _formkey2 = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Appwidget.text(
            title: 'Login_POST_API', textWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey2,
          child: Column(
            children: [
              _textfield(EmailController, 'Email ', EmailFocus, PassFocus,
                  Icon(Icons.email_outlined), false),
              SizedBox(
                height: 20,
              ),
              _textfield(PassController, 'Password', PassFocus, null,
                  Icon(Icons.password), true),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey2.currentState!.validate()) {
                      final loginResponse = loginProvider.loginUser(
                          EmailController.text, PassController.text);

                      loginResponse.then((response) {
                        if (loginProvider.statusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Appwidget.text(
                                  title:
                                      "Token : ${loginProvider.loginResponse.token!} ",
                                  tColor: Colors.white)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Appwidget.text(
                                  title: loginProvider.loginResponse.error!,
                                  tColor: Colors.white)));
                        }
                      });
                    }
                  },
                  child: Appwidget.text(title: "Login", tColor: Colors.purple))
            ],
          ),
        ),
      ),
    );
  }

  Widget _textfield(
      TextEditingController controller,
      String label,
      FocusNode focusNode,
      FocusNode? focusNodeNext,
      Icon? iconData,
      bool isPassword) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$label required";
        }
        return null;
      },
      obscureText: isPassword,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: iconData,
          hintText: label),
      onFieldSubmitted: (String val) {
        feildfocusChange(context, focusNode, focusNodeNext);
      },
    );
  }

  feildfocusChange(
      BuildContext context, FocusNode currentfocus, FocusNode? nextfocus) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }
}
