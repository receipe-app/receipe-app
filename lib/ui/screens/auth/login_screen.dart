// LoginScreen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/ui/screens/auth/sign_up_screen.dart';
import 'package:receipe_app/ui/widgets/custom_textfield.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter Email',
                isEmail: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Enter Password',
                hint: 'Enter Password',
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.orange)),
                ),
              ),
              const SizedBox(height: 16),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.error ?? 'An error occurred')),
                    );
                  } else if (state.authStatus == AuthStatus.authenticated) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                builder: (context, state) {
                  return state.authStatus == AuthStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthEvent.loginUser(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Sign In'),
                          ),
                        );
                },
              ),
              const SizedBox(height: 16),
              const Center(child: Text('Or Sign in With')),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (ctx) => RegisterScreen())),
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
