import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/data/service/dio/user_dio_service.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/logic/bloc/user/user_bloc.dart';
import 'package:receipe_app/logic/cubit/tab_box/tab_box_cubit.dart';
import 'package:receipe_app/ui/screens/auth/login_screen.dart';
import 'package:receipe_app/ui/screens/home/home_screen.dart';
import 'package:toastification/toastification.dart';
import 'data/repositories/user_repository.dart' as user;

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final UserDioService userDioService = UserDioService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              user.UserRepository(userDioService: userDioService),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: authenticationRepository),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<user.UserRepository>(),
            ),
          ),
          BlocProvider(create: (context) => TabBoxCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primary100,
            selectionColor: AppColors.primary100.withOpacity(0.1),
            selectionHandleColor: AppColors.primary100,
          ),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: context.read<AuthBloc>()..add(const CheckTokenExpiryEvent()),
          builder: (context, state) {
            if (state.authStatus == AuthStatus.authenticated) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
