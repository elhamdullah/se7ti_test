import 'package:flutter/material.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/feature/patient/appointments/appointments_list.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'مواعيد الحجز',
        ),
        centerTitle: true,
        backgroundColor: AppColors.color1,
        foregroundColor: AppColors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: MyAppointmentList(),
      ),
    );
  }
}