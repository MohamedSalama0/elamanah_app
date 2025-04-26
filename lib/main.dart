import 'package:farm_project/core/cubits/auth/auth_cubit.dart';
import 'package:farm_project/src/presentation/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthCubit()),
      ],
      child: MaterialApp(
        title: 'Farm Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Colors.green.shade700,
            secondary: Colors.blue.shade400,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
            ),
          ),
          iconTheme: const IconThemeData(
            size: 48,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
