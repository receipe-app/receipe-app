import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/data/repositories/recipe_repository.dart';
import 'package:receipe_app/data/service/dio/user_dio_service.dart';
import 'package:receipe_app/data/service/firebase_recipe_service.dart';
import 'package:receipe_app/firebase_options.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/logic/bloc/recipe/recipe_bloc.dart';
import 'package:receipe_app/logic/bloc/user/user_bloc.dart';
import 'package:receipe_app/logic/cubit/tab_box/tab_box_cubit.dart';
import 'package:receipe_app/ui/screens/splash/splash_screen.dart';
import 'package:toastification/toastification.dart';

import 'data/repositories/user_repository.dart' as user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: '.env');
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final UserDioService userDioService = UserDioService();

  final firebaseRecipeService = FirebaseRecipeService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              user.UserRepository(userDioService: userDioService),
        ),
        RepositoryProvider(
          create: (context) =>
              RecipeRepository(firebaseRecipeService: firebaseRecipeService),
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
          BlocProvider(
            create: (context) => RecipeBloc(
              recipeRepository: context.read<RecipeRepository>(),
            ),
          )
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
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        ensureScreenSize: true,
        builder: (context, _) {
          return ToastificationWrapper(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Authentication Bloc',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.primary100,
                  selectionColor: AppColors.primary100.withOpacity(0.1),
                  selectionHandleColor: AppColors.primary100,
                ),
              ),
              home: BlocBuilder<AuthBloc, AuthState>(
                bloc: context.read<AuthBloc>()
                  ..add(const CheckTokenExpiryEvent()),
                builder: (context, state) {
                  if (state.authStatus == AuthStatus.authenticated) {
                    return const MainScreen();
                  } else {
                    return const LoginScreen();
                  }
                },
              ),
            ),
          );
        });
  }
}
