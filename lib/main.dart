import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/ui/screens/auth/login_screen.dart';
import 'package:receipe_app/ui/screens/home/home_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: _authenticationRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication Bloc',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BlocBuilder<AuthBloc, AuthState>(
          // bloc: context.read<AuthBloc>()..add(CheckToki),
          builder: (context, state) {
            if (state.authStatus == AuthStatus.authenticated) {
              return HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
