
import 'package:flood/data/models/login_model.dart';
import 'package:flood/data/models/response_model.dart';
import 'package:flood/data/services/network.dart';
import 'package:flood/data/urls.dart';
import 'package:flood/data/utils/auth_utils.dart';
import 'package:flood/ui/screens/auth/signup_screen.dart';
import 'package:flood/ui/screens/bottom_navbar_screen.dart';
import 'package:flood/ui/screens/home_screen.dart';
import 'package:flood/ui/widgets/custom_button.dart';
import 'package:flood/ui/widgets/custom_password_text_field.dart';
import 'package:flood/ui/widgets/custom_text_form_field.dart';
import 'package:flood/ui/widgets/signup_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loginInProgress = false;

  Future<void> login() async {
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text
    };
    
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.loginUrl, requestBody);
    
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.setUserInfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        _passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Image.asset("assets/images/flood.png", width: 120, fit: BoxFit.contain),
                const SizedBox(height: 40),
                Text(
                  "Getting Start With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: CustomTextFormField(
                      hintText: "Email",
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 12),
                CustomPasswordTextFormField(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _loginInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: CustomButton(
                    text: "Login Sekarang",
                    onPress: () {
                      login();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.grey, letterSpacing: .7),
                    ),
                  ),
                ),
                Visibility(
                  child: SignUpButton(
                    text: "Don't have An Account?",
                    onPresse: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpFormScreen()),
                      );
                    },
                    buttonText: 'Sign Up',
                  ),
                ),
              const SizedBox(height: double.maxFinite)],
            ),
          ),
        ),
    );
  }
}