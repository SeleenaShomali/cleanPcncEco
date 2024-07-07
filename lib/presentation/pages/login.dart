import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/presentation/controller/login_controller.dart';

class Login extends StatelessWidget {
  final LoginController lcontroller = Get.find<LoginController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 120, top: 70),
              child: Container(width: 200, child: _header()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: _inputFiled(),
            ),
            _signUp(),
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

  Widget _inputFiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: "Username or Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(
          height: 35,
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Forget Password?",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
          onPressed: () {
            lcontroller.login(emailController.text, passwordController.text);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.orange),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Get.toNamed('/signup');
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
