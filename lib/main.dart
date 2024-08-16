import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_configuration.dart';
import 'core/app.dart';

late Box recipeBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfiguration.setUp();
  AppConfiguration.dependencySetup();

  runApp(
    MultiBlocProvider(
      providers: allBlocs,
      child: const MyApp(),
    ),
  );
}
