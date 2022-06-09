import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              defaultTextFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'email must not be empty.';
                  }
                  return null;
                },
                onSubmit: (value) {
                  print(value);
                },
                onChange: (value) {
                  print(value);
                },
                prefixIcon: Icons.email,
                label: 'Email Address',
              ),
              SizedBox(
                height: 15.0,
              ),
              defaultTextFormField(
                controller: passwordController,
                type: TextInputType.visiblePassword,
                secure: secure,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Password must not be null.';
                  }
                  return null;
                },
                onSubmit: (value) {
                  print(value);
                },
                onChange: (value) {
                  print(value);
                },
                suffixIcon: secure ? Icons.visibility_off : Icons.visibility,
                onPressed: () {
                  setState(() {
                    secure = !secure;
                  });
                },
                prefixIcon: Icons.lock_rounded,
                label: 'Password',
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    print(passwordController.text);
                  }
                },
                text: 'LOGIN',
                background: Colors.blue,
              ),
              SizedBox(
                height: 9.0,
              ),
              defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    print(emailController.text);
                  }
                },
                text: 'REGISTER',
                background: Colors.red,
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
