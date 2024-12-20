import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/feature/patient/home/presentation/page/home_search_view.dart';
import 'package:se7ety_123/feature/patient/home/presentation/widgets/specialists_widget.dart';
import 'package:se7ety_123/feature/patient/home/presentation/widgets/top_rated_widget.dart';

class PatientHomeView extends StatefulWidget {
  const PatientHomeView({super.key});

  @override
  State<PatientHomeView> createState() => _PatientHomeViewState();
}

class _PatientHomeViewState extends State<PatientHomeView> {
  final TextEditingController _doctorName = TextEditingController();
  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    log(user?.displayName.toString() ?? "");
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_active)),
          )
        ],
        backgroundColor: AppColors.white,
        //////
        centerTitle: true,
        title: Text(
          "صــــــحّـتــي",
          style: getTitleStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "مرحبا",
                    style: getTitleStyle(),
                  ),
                  TextSpan(
                    text: user?.displayName,
                    style: getTitleStyle(),
                  ),
                ]),
              ),
              const Gap(10),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: getTitleStyle(color: AppColors.black),
              ),
              const Gap(15),

              // ---------Search-------

              Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(5, 5))
                    ]),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _doctorName,
                  cursorColor: AppColors.color1,
                  decoration: InputDecoration(
                      hintStyle: getBodyStyle(),
                      hintText: 'ابحث عن دكتور',
                      filled: true,
                      fillColor: AppColors.accentColor,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide.none),
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: AppColors.color1.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: IconButton(
                            onPressed: () {
                              if (_doctorName.text.isNotEmpty) {
                            pushTO(context,
                               HomeSearchView (searchKey: _doctorName.text));
                          }

                            },
                            iconSize: 20,
                            splashRadius: 20,
                            color: Colors.white,
                            icon: const Icon(Icons.search)),

                      )
                      ),

                      onFieldSubmitted: (String value) {
                    if (_doctorName.text.isNotEmpty) {
                      pushTO(
                          context, HomeSearchView(searchKey: _doctorName.text));
                    }
                  },
                ),
              ),

              
              const Gap(16),
              // ----------------  SpecialistsWidget --------------------,
              const SpecialistsBanner(),
              const Gap(10),
              // ----------------  Top Rated --------------------,
              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: getTitleStyle(fontSize: 16),
              ),
              const Gap(10),

              const TopRatedList()
            ],
          ),
        ),
      ),
    );
  }
}


