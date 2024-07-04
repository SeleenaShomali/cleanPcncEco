import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Data/repository/sign_up_datarepoImp.dart';
import 'package:pcnc_ecommerce/Data/sources/Sign_remoteDataS.dart';
import 'package:pcnc_ecommerce/Domain/usecases/sign_up_usecase.dart';
import 'package:pcnc_ecommerce/presentation/controller/sign_up_controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final SRemoteDataSource remoteDataSource = SRemoteDataSource();
final SignupRepositoryImpl signupRepository = SignupRepositoryImpl(remoteDataSource: remoteDataSource);
final SignupUseCase signupUseCase = SignupUseCase(repository: signupRepository);
   final SignupController signupController = Get.put(SignupController(signupUseCase: signupUseCase));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  _header(),
                  const SizedBox(height: 20),
                ],
              ),
              _inputFiled(signupController),
              _text(),
              _signUp(signupController),
              _lastText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(right: 120, top: 40),
      child: Container(
        width: 200,
        child: Text(
          "Create an Account",
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
    return Column(
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            fillColor: Colors.black.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),
      ],
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
        const Text("Already have an account?"),
        TextButton(
          onPressed: () {
            Get.toNamed('/login');
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
