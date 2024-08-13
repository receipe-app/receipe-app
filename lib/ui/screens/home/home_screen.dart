import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthEvent.logout());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
