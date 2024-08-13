import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/core/app.dart';
import 'package:receipe_app/ui/widgets/custom_textfield.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create an account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Let's help you set up your account,\nit won't take long.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Enter Name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter Email',
                isEmail: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Enter Password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                hint: 'Retype Password',
                isPassword: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.orange,
                  ),
                  const Text(
                    'Accept terms & Condition',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 24),
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
                                      AuthEvent.registerUser(
                                        name: _nameController.text,
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
                            child: const Text('Sign Up'),
                          ),
                        );
                },
              ),
              const SizedBox(height: 16),
              const Center(child: Text('Or Sign in With')),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "Already a member? "),
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
