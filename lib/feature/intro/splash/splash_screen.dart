import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/enums/user_type_enum.dart';
import 'package:se7ety_123/core/services/local_storage.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/feature/intro/onboarding/page/onboarding_screen.dart';
import 'package:se7ety_123/feature/intro/welcome/welcome_screen.dart';
import 'package:se7ety_123/feature/patient/nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    getUser();
    Future.delayed(const Duration(seconds: 3), () {
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.kOnboarding) ==
              true;
        

      if(user !=null){
       if( user?.photoURL == UserType.doctor.toString()){
        //
       }
       else{
          pushReplacement(context, const PatientNavBarWidget());
       }
      }else{
         if (isOnboardingShown) {
        pushReplacement(context, const WelcomeScreen());
      } else {
        pushReplacement(context, const OnboardingScreen());
      }
      }
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 300,
        ),
      ),
    );
  }
}
