import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/ui/screens/auth/login_screen.dart';
import 'package:receipe_app/ui/screens/home/home_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(authRepository: authenticationRepository),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Bloc',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocConsumer<AuthBloc, AuthState>(
        bloc: context.read<AuthBloc>()..add(const CheckTokenExpiryEvent()),
        listener: (context, state) {
          if (state.authStatus == AuthStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state.authStatus == AuthStatus.unauthenticated ||
              state.authStatus == AuthStatus.authenticated) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          print(state.error);
          print(state);
          if (state.authStatus == AuthStatus.authenticated) {
            return const HomeScreen();
          } else if (state.authStatus == AuthStatus.unauthenticated) {
            return const LoginScreen();
          }
          return const SizedBox();
        },

      ),
    );
  }
}
