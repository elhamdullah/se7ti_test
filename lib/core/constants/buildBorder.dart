import 'package:flutter/material.dart';
import 'package:se7ety_123/core/utils/colors.dart';

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: AppColors.color1));
}
