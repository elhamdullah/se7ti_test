// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_123/core/services/local_storage.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_bloc.dart';
import 'package:se7ety_123/feature/intro/splash/splash_screen.dart';
import 'package:se7ety_123/firebase_options.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppLocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const MaterialApp(
      
         localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
        ],
      
       
        supportedLocales: [Locale("ar"),],
        locale: Locale("ar"),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),  
      ),
    );
  }
}
