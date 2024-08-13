import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/logic/cubit/tab_box/tab_box_cubit.dart';
import 'package:receipe_app/ui/screens/auth/login_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:receipe_app/ui/screens/home/home_screen.dart';
import 'package:receipe_app/ui/screens/profile/profile_screen.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(authRepository: authenticationRepository),
    ),
    BlocProvider(create: (context) => TabBoxCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: BlocConsumer<AuthBloc, AuthState>(
        bloc: context.read<AuthBloc>()..add(const CheckTokenExpiryEvent()),
        listener: (context, state) {
          if (state.authStatus == AuthStatus.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
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
