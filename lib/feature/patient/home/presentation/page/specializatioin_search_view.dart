import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/doctor_card.dart';
import 'package:se7ety_123/feature/auht/data/doctor_model.dart';

class SpecializationSearchView extends StatefulWidget {
  final String specialization;
  const SpecializationSearchView({super.key, required this.specialization});

  @override
  _SpecializationSearchViewState createState() =>
      _SpecializationSearchViewState();
}

class _SpecializationSearchViewState extends State<SpecializationSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.color1,
        foregroundColor: AppColors.white,
        title: Text(
          widget.specialization,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('doctors')
            .where('specialization', isEqualTo: widget.specialization)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/no-search.svg',
                          width: 250,
                        ),
                        Text(
                          'لا يوجد دكتور بهذا التخصص حاليا',
                          style: getTitleStyle(),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      if (doctor.specialization == '') {
                        return const SizedBox();
                      }
                      return DoctorCard(
                        doctor: doctor,
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}