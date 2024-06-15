import 'dart:developer';

import 'package:flood/data/models/response_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/ui/screens/auth/login_screen.dart';
import 'package:flood/ui/widgets/custom_button.dart';
import 'package:flood/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordConfirmationController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  Future<void> userSignUp() async {
    _signUpInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "name": _nameController.text.trim(),
      "password": _passwordController.text,
      "password_confirmation": _passwordConfirmationController.text
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registrationUrl, requestBody);
    _signUpInProgress = false;

    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();
      _passwordConfirmationController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful"),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Failed"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Image.asset("assets/images/flood.png", width: 120, fit: BoxFit.contain),
                const SizedBox(height: 40),
                Text(
                  "Join With Us",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: 'Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,5}')
                            .hasMatch(value)) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: _passwordConfirmationController,
                  hintText: 'Confirm Password',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your confirmation password';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _signUpInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: CustomButton(
                      text: "Daftar Sekarang",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          userSignUp();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an Account?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(letterSpacing: .7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}