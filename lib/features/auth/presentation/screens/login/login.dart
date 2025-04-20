import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:order_traking/features/auth/presentation/widgets/custom_text_buttom.dart';
import 'package:order_traking/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:order_traking/features/auth/presentation/widgets/snackBar.dart';
import 'package:order_traking/features/auth/presentation/widgets/validators.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {
        if(state is AuthSuccess)
          {
           Navigator.pushNamedAndRemoveUntil(context, "home",(route) => false,) ;
          }
        else if (state is AuthFail) {
         Snackbarss.showSnackBar(context, state.message.toString());
        } else if (state is AuthResetPasswordSuccess) {
          Snackbarss.showSnackBar(context, "Reset password message Sent");
        }
      },
      builder: (context, state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key:_formKey ,
            child: Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'LOG IN',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Subtitle
                        const Text(
                          'Enter your details below to log in',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Email CustomTextField
                        CustomTextField(
                          validator: (p0) {
                            Validators.emailValidator(p0);
                          },
                          labelText: 'Your Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        // Password CustomTextField
                        CustomTextField(
                          validator: (p0) {
                            Validators.passwordValidator(p0);
                          },
                          labelText: 'Password',
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (_emailController.text.isNotEmpty) {
                                authCubit.resetPassword(_emailController.text);
                              } else {
                                Snackbarss.showSnackBar(context, "PLEASE Enter Email  ");
                              }
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Log In Button (CustomElevatedButton)
                        CustomElevatedButton(
                          text:state is AuthLoading? "Loading...." : 'Log in',
                          onPressed: () {
                            if(_formKey.currentState!.validate())
                              {
                                final email = _emailController.text.trim();
                                final password = _passwordController.text.trim();
                                authCubit.login(email, password);
                              }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Sign Up Link
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'signUp');
                                    },
                                    child: const Text(
                                      'Sign up',
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
      }
    );
  }
}