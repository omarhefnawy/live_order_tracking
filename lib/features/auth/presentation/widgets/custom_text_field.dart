import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;                  // نص العنوان فوق الحقل
  final TextEditingController controller;  // كنترولر للتحكم بالقيمة
  final TextInputType keyboardType;         // نوع لوحة المفاتيح (نص - رقم - بريد...)
  final bool isPassword;                    // هل الحقل باسورد؟
  final String? errorText;                  // رسالة خطأ (اختياري)
  final String? Function(String?)? validator; // دالة تحقق من صحة الإدخال
  final void Function()? onTap;              // دالة تنفيذ عند الضغط على الحقل
  final bool? readOnly;                      // هل الحقل للقراءة فقط؟

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.errorText,
    this.validator,
    this.onTap,
    this.readOnly,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false; // عشان نظهر أو نخفي الباسورد

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && !_isPasswordVisible,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,              // تكبير الخط للعناوين
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), // توسيع الحقل
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),   // حواف أنعم
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue, width: 2), // لون أزرق عند التركيز
        ),
        errorText: widget.errorText,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        )
            : null,
      ),
      style: const TextStyle(
        fontSize: 18,              // تكبير الخط داخل الحقل
        color: Colors.black87,
      ),
    );
  }
}
