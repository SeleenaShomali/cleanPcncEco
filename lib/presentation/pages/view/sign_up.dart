import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecommerce/Data/repository/sign_up_datarepoImp.dart';
import 'package:pcnc_ecommerce/Data/sources/Sign_remoteDataS.dart';
import 'package:pcnc_ecommerce/Domain/usecases/sign_up_usecase.dart';
import 'package:pcnc_ecommerce/core/function/Validation_input.dart';
import 'package:pcnc_ecommerce/presentation/controller/sign_up_controller.dart';

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
    final SRemoteDataSource remoteDataSource = SRemoteDataSource();
    final SignupRepositoryImpl signupRepository =
        SignupRepositoryImpl(remoteDataSource: remoteDataSource);
    final SignupUseCase signupUseCase =
        SignupUseCase(repository: signupRepository);
    final SignupController signupController =
        Get.put(SignupController(signupUseCase: signupUseCase));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 40),
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
      padding: const EdgeInsets.only(right: 154, top: 63),
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
            TextFormField(
              validator: (value) {
                return validInput(value!, 'Username');
              },
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.black.withOpacity(0.03),
                filled: true,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 31),
            TextFormField(
              validator: (value) {
                return validInput(value!, 'Email');
              },
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.black.withOpacity(0.03),
                filled: true,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 31),
            TextFormField(
              validator: (value) {
                return validInput(value!, 'Password');
              },
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
                  icon: Icon(signupController.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    signupController.toggleObscure();
                  },
                ),
              ),
              obscureText: signupController.isObscure.value,
            ),
            const SizedBox(height: 31),
            TextFormField(
              validator: (value) {
                return validInput(value!, 'Password');
              },
              controller: confirmPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.black.withOpacity(0.03),
                filled: true,
                prefixIcon: const Icon(Icons.lock),
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
