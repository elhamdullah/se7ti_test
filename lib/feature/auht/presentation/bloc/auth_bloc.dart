// feature/auht/presentation/bloc/auth_bloc.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_123/core/enums/user_type_enum.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_event.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<UpdateDoctorDataEvent>(updateDoctorData);
  }

// Login
  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      credential.user?.photoURL;

      emit(LoginSuccessState(userType: credential.user?.photoURL ?? ""));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuhtErrorState(message: "المستخدم غير موجود"));
      } else if (e.code == 'wrong-password') {
        emit(AuhtErrorState(message: "الباسورد ضعيف"));
      } else {
        emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
      }
    } catch (e) {
      emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
    }
  }

// Register
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());

    try {
      // Register user with Firebase Authentication
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      User? user = credential.user;
      user?.uid;
      await user?.updateDisplayName(event.name);
      await user?.updatePhotoURL(event.userType.toString());

      if (user != null) {
        // Update user details
        await user.updateDisplayName(event.name);
        await user.updatePhotoURL(event.userType.toString());

        // Prepare Firestore data based on user type

        if (event.userType == UserType.doctor) {
          FirebaseFirestore.instance
              .collection('unregisteredDoctors')
              .doc(user.uid)
              .set({
            'name': event.name,
            'email': event.email,
            'image': '',
            'specialization': '',
            'rating': '',
            'phone1': '',
            'phone2': '',
            'bio': '',
            'openHour': '',
            'closeHour': '',
            'uid': user.uid,
          });
        } else {
          FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
            'name': event.name,
            'email': event.email,
            'image': '',
            'age': '',
            'phone': '',
            'bio': '',
            'city': '',
            'uid': user.uid,
          });
        }
        print(user.uid);

        emit(RegisterSuccessState());
      } else {
        emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth-specific errors
      if (e.code == 'weak-password') {
        emit(AuhtErrorState(message: "الباسورد ضعيف"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuhtErrorState(message: "الاميل مستخدم من قبل"));
      } else {
        emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
      }
    } catch (e) {
      // Handle generic errors
      emit(AuhtErrorState(message: "حدث مشكله ما حاول مره اخري "));
    }
  }

  Future<void> updateDoctorData(
      UpdateDoctorDataEvent event, Emitter<AuthState> emit) async {
    emit(DoctorRegistionLoadingState());

    try {
      log("-------1-----");
      final docRef = FirebaseFirestore.instance
          .collection('unregisteredDoctors')
          .doc(event.doctorModel.uid);

      // Check if the document exists
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update the existing document
        await docRef.update(event.doctorModel.toJson());
        log("-------2-----");
        emit(DoctorRegistionSuccessState());
      } else {
        // Document does not exist, save to another category
        log("Document not found, saving to 'unregisteredDoctors'");
        final fallbackRef = FirebaseFirestore.instance
            .collection('unregisteredDoctors')
            .doc(event.doctorModel.uid);

        await fallbackRef.set(event.doctorModel.toJson());
        emit(DoctorRegistionSuccessState());
      }
    } catch (e) {
      log("-------3-----");
      log("Error: $e");
      emit(AuhtErrorState(message: "حدث خطا ما يرجي محاوله مرة اخري"));
    }
  }
}
