import 'package:flutter/material.dart';
import 'package:order_traking/core/contsants/colorConstant.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;             // نص الزر
  final VoidCallback onPressed;  // الوظيفة عند الضغط

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // يجعل الزر يأخذ العرض كامل
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor, // لون خلفية الزر
          foregroundColor: ColorConstants.bodyColor,     // لون تأثيرات الضغط
          padding: const EdgeInsets.symmetric(vertical: 20), // تكبير المسافة الرأسية داخل الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),    // تكبير استدارة الزر
          ),
          elevation: 6, // إضافة ظل خفيف للزر لجعله بارز أكثر
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,          // تكبير الخط
            fontWeight: FontWeight.bold, // جعل الخط سميك
            color: Colors.white,   // لون النص
            letterSpacing: 1.5,    // زيادة تباعد الأحرف لجمالية أكبر
          ),
        ),
      ),
    );
  }
}
