import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/core/function/Validation_input.dart';
import 'package:pcnc_ecommerce/features/login_feature/presentation/controller/login_controller.dart';
import 'package:pcnc_ecommerce/features/dashboard/presentation/components/Custom_text_filed.dart';

class Login extends StatelessWidget {
  final LoginController lcontroller = Get.find<LoginController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 154, top: 63),
                  child: Container(width: 200, child: _header()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: _inputFiled(context),
                ),
                _signUp(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Column(
      children: [
        Text(
          "Welcome Back!",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _inputFiled(BuildContext context) {
    return Obx(
      () => Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: emailController,
              hintText: "Username or Email",
              validator: (value) {
                return validInput(value!, 'Email');
              },
              prefixIcon: Icon(Icons.person_sharp),
              obscureText: false,
            ),
            const SizedBox(height: 31),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              validator: (value) {
                return validInput(value!, 'Password');
              },
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  lcontroller.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Color.fromARGB(255, 14, 14, 14),
                ),
                onPressed: () {
                  lcontroller.toggleObscure();
                },
              ),
              obscureText: lcontroller.isObscure.value,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password?",
                    style: TextStyle(color: Color(0xFFCD3534)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {
             //   if (_formKey.currentState!.validate()) {
                  lcontroller.login(
                    emailController.text,
                    passwordController.text,
                  );
               // }
              },
            //   ElevatedButton(
            //  onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //      lcontroller.login(
            //          emailController.text, passwordController.text);
            //     } else {
            //       // Show Snackbar if form is invalid
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(
            //               'Please fix the errors in red before submitting.'),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //     }
            //  },
              
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Create An Account"),
        TextButton(
          onPressed: () {
            Get.toNamed('/signup');
          },
          child: const Text(
            "Sign Up",
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
