import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/single_child_widget.dart';
import 'package:receipe_app/logic/bloc/blocs.dart';
import 'package:receipe_app/logic/cubit/tab_box/tab_box_cubit.dart';

import 'main.dart';
import 'firebase_options.dart';
import 'data/model/models.dart';
import 'data/service/services.dart';
import 'data/repositories/repositories.dart';

final GetIt getIt = GetIt.I;

class AppConfiguration {
  static Future<void> setUp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await Hive.initFlutter();

    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(IngredientAdapter());
    Hive.registerAdapter(InstructionAdapter());
    Hive.registerAdapter(CommentAdapter());

    await dotenv.load(fileName: '.env');

    recipeBox = await Hive.openBox('recipes');
  }

  static void dependencySetup() {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    final firebaseRecipeService = FirebaseRecipeService();
    final UserDioService userDioService = UserDioService();

    /// registering repos
    getIt.registerLazySingleton(
      () => RepositoryProvider(
        create: (context) => UserRepository,
      ),
    );
    getIt.registerLazySingleton(
      () => UserRepository(userDioService: userDioService),
    );
    getIt.registerLazySingleton(
      () => RecipeRepository(firebaseRecipeService: firebaseRecipeService),
    );

    /// registering blocs
    getIt.registerLazySingleton(
      () => AuthBloc(authRepository: authenticationRepository),
    );
    getIt.registerLazySingleton(
      () => UserBloc(userRepository: getIt.get<UserRepository>()),
    );
    getIt.registerLazySingleton(
      () => RecipeBloc(recipeRepository: getIt.get<RecipeRepository>()),
    );
    getIt.registerLazySingleton(
      () => SavedRecipeBloc(userRepository: getIt.get<UserRepository>()),
    );
    getIt.registerLazySingleton(
      () => LikedRecipeBloc(userRepository: getIt.get<UserRepository>()),
    );

    getIt.registerLazySingleton(() => TabBoxCubit());
  }
}

List<SingleChildWidget> allBlocs = [
  BlocProvider.value(value: getIt.get<AuthBloc>()),
  BlocProvider.value(value: getIt.get<UserBloc>()),
  BlocProvider.value(value: getIt.get<TabBoxCubit>()),
  BlocProvider.value(value: getIt.get<RecipeBloc>()),
  BlocProvider.value(value: getIt.get<SavedRecipeBloc>()),
  BlocProvider.value(value: getIt.get<LikedRecipeBloc>()),
];
