import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/core/function/Validation_input.dart';
import 'package:pcnc_ecommerce/presentation/controller/sign_up_controller.dart';
import 'package:pcnc_ecommerce/presentation/pages/components/Custom_text_filed.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SignupController signupController = Get.find<SignupController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height - 40,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                  
                      _header(),
                      const SizedBox(height: 20),
                    ],
                  ),
                  _inputFiled(signupController),
                        const SizedBox(height: 15),
                  _text(),
                      const SizedBox(height: 30),
                  _signUp(signupController),
                  
                  _lastText(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(right: 140, top: 33),
      child: Container(
        width: 200,
        child: Text(
          "Create an account",
          style: TextStyle(
            fontSize: 36,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _inputFiled(SignupController signupController) {
    return Obx(
      () => Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: nameController,
              hintText: "Username",
              validator: (value) {
                return validInput(value!, 'Username');
              },
              prefixIcon: Icon(Icons.person),
              obscureText: false,
            ),
            const SizedBox(height: 31),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              validator: (value) {
                return validInput(value!, 'Email');
              },
              prefixIcon: Icon(Icons.email),
              obscureText: false,
            ),
            const SizedBox(height: 31),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              validator: (value) {
                return validInput(value!, 'Password');
              },
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  signupController.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  signupController.toggleObscure();
                },
              ),
              obscureText: signupController.isObscure.value,
            ),
            const SizedBox(height: 31),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              validator: (value) {
                return validInput(value!, 'Password');
              },
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  signupController.isObscure1.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  signupController.toggleObscure2();
                },
              ),
              obscureText: signupController.isObscure1.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return RichText(
      text: const TextSpan(
        text: 'By clicking the ',
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: 'Register',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' button, you agree to the public offer',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _signUp(SignupController signupController) {
    return Container(
      padding: const EdgeInsets.only(top: 3, left: 3),
      child: ElevatedButton(
        onPressed: () {
          if (passwordController.text == confirmPasswordController.text) {
            signupController.signup(
              nameController.text,
              emailController.text,
              passwordController.text,
            );
          } else {
            Get.snackbar('Error', 'Passwords do not match');
          }
        },
        child: Text(
          "Create Account",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  Widget _lastText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("I Already have an account?"),
        TextButton(
          onPressed: () {
            Get.toNamed('/login');
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: Color(0xFFCD3534),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFCD3534),
            ),
          ),
        ),
      ],
    );
  }
}
