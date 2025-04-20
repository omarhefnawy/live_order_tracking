import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:order_traking/features/auth/presentation/widgets/custom_text_buttom.dart';
import 'package:order_traking/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:order_traking/features/auth/presentation/widgets/snackBar.dart';
import 'package:order_traking/features/auth/presentation/widgets/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Snackbarss.showSnackBar(context, "Sign up successful! Please verify your email.");
          Navigator.pushReplacementNamed(context, "login");
        } else if (state is AuthFail) {
          Snackbarss.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Create an account to get started',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomTextField(
                          validator: (p0) {
                            Validators.emailValidator(p0);
                          },
                          labelText: 'Your Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          labelText: 'Password',
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          validator: (p0) {
                            Validators.confirmPasswordValidator(p0,_passwordController.text);
                          },
                          labelText: 'Confirm Password',
                          controller: _confirmPasswordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        CustomElevatedButton(
                          text: state is AuthLoading ? 'loading.....' : 'Sign up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              final confirm = _confirmPasswordController.text.trim();
                              if(confirm==password)
                                {
                                  authCubit.signUp(email, password);
                                }

                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      },
    );
  }
}