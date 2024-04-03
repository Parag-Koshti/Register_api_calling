import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igenerate_16/API/register_provider.dart';
import 'package:igenerate_16/custome_widget/widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Appwidget.text(
            title: "Register_POST_API", textWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              _textfield(emailController, "Email", emailFocus, passFocus,
                  Icon(Icons.mail), false),
              SizedBox(
                height: 20,
              ),
              _textfield(passController, "Password", passFocus, null,
                  Icon(Icons.lock), true),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      final registerResponse = registerProvider.registerUser(
                          emailController.text, passController.text);

                      registerResponse.then((response) {
                        if (registerProvider.statusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Appwidget.text(
                                  title:
                                      "Token : ${registerProvider.registerResponse.token!}  Id:${registerProvider.registerResponse.id}",
                                  tColor: Colors.white)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Appwidget.text(
                                  title:
                                      "${registerProvider.registerResponse.error!}",
                                  tColor: Colors.white)));
                        }
                      });
                    }
                  },
                  child:
                      Appwidget.text(title: "Register", tColor: Colors.purple))
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
      onFieldSubmitted: (Stringval) {
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
