class Validators{
  static String? ordinaryValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your requiredData';
    }
    return null;
  }
  // Validator للبريد الإلكتروني
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    // التحقق من تنسيق البريد الإلكتروني باستخدام تعبير منتظم
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Please enter a valid email (e.g., example@domain.com)';
    }
    return null;
  }

// Validator لكلمة المرور
  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    // التحقق من وجود حرف كبير، حرف صغير، ورقم (اختياري لزيادة الأمان)
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value.trim())) {
      return 'Password must include uppercase, lowercase, and a number';
    }
    return null;
  }

// Validator لتأكيد كلمة المرور
 static String? confirmPasswordValidator(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value.trim() != password.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }
}