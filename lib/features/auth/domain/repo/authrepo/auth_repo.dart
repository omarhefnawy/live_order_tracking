import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo{
  Future<UserCredential> signIn({required String email , required String password});
  Future<UserCredential> signUp({required String email , required String password});
  Future<void> logOut ();
  Future<void> resetPassword({required String email});
}