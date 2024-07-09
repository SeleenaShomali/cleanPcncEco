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
              padding: const EdgeInsets.only(right: 154, top: 63),
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
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: "Username or Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.black.withOpacity(0.03),
              filled: true,
              prefixIcon: Icon(Icons.person_sharp),
            ),
          ),
          const SizedBox(height: 31),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.black.withOpacity(0.03),
              filled: true,
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
              lcontroller.login(emailController.text, passwordController.text);
            },
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
