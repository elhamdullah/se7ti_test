// feature/auht/presentation/page/login_view.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/constants/App_assets.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/enums/user_type_enum.dart';
import 'package:se7ety_123/core/functions/dialogs.dart';
import 'package:se7ety_123/core/functions/email_validate.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/custom_button.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_bloc.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_event.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_state.dart';
import 'package:se7ety_123/feature/auht/presentation/page/doctor_registeration.dart';
import 'package:se7ety_123/feature/auht/presentation/page/register_view.dart';
import 'package:se7ety_123/feature/doctor/profile/page/profile_view.dart';
import 'package:se7ety_123/feature/patient/home/presentation/page/home_view.dart';
import 'package:se7ety_123/feature/patient/nav_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.userType});
  final UserType userType;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String handleUserType() {
    return (widget.userType == UserType.doctor) ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            log("Success");
            if (state.userType == UserType.doctor.toString()) {
              pushAndRemoveUntil(context, const DoctorRegistrationView());
            } //DoctorNavBarWidget
            else {
              pushAndRemoveUntil(context, const PatientNavBarWidget());
            }
          } else if (state is LoginLoadingState) {
            showLoadingDialog(context);
          } else if (state is AuhtErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.message);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // image
                    Image.asset(
                      AppAssets.logoPng,
                      height: 200,
                    ),

                    const Gap(20),

                    // text
                    Text(
                      'سجل دخول الان كـ "${handleUserType()}"',
                      style: getTitleStyle(),
                    ),

                    const Gap(30),

                    // email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintText: 'mohamed@example.com',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: AppColors.color1,
                        ),
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!emailValidate(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const Gap(20),

                    // password
                    TextFormField(
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: AppColors.black),
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(
                              (isVisible)
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_rounded,
                              color: AppColors.color1,
                            )),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.color1,
                        ),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),

                    const Gap(30),

                    // button
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(LoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                                userType: widget.userType.toString(),
                              ));
                        }
                      },
                      text: "تسجيل الدخول",
                    ),

                    // text
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لدي حساب ؟',
                            style: getBodyStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                              onPressed: () {
                                pushReplacement(context,
                                    RegisterView(userType: widget.userType));
                              },
                              child: Text(
                                'سجل الان',
                                style: getBodyStyle(
                                    color: AppColors.color1,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
