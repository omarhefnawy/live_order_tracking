import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_traking/features/auth/data/repo_imp/authRepoImp/auth_repo_imp.dart';
import 'package:order_traking/features/auth/domain/repo/authrepo/auth_repo.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo repo;
  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthFail("Email and password cannot be empty."));
      return;
    }
    emit(AuthLoading());
    try {
      UserCredential user = await repo.signIn(email: email, password: password);
      if (user.user != null && user.user!.emailVerified) {
        emit(AuthSuccess(user.user!));
      } else {
        emit(AuthFail("Please verify your email before logging in."));
      }
    } catch (e) {
      String errorMessage = switch (e.toString()) {
        String s when s.contains('wrong-password') => 'Incorrect password.',
        String s when s.contains('user-not-found') => 'No user found with this email.',
        String s when s.contains('invalid-email') => 'Invalid email format.',
        _ => 'Failed to sign in: ${e.toString()}',
      };
      emit(AuthFail(errorMessage));
    }
  }

  Future<void> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthFail("Email and password cannot be empty."));
      return;
    }
    emit(AuthLoading());
    try {
      UserCredential user = await repo.signUp(email: email, password: password);
      if (user.user != null) {
        await user.user!.sendEmailVerification();
        await repo.logOut();
        emit(SignUpSuccess());
      }
    } catch (e) {
      emit(AuthFail("Failed to sign up: ${e.toString()}"));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    try {
      await repo.logOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFail("Failed to log out: ${e.toString()}"));
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(AuthFail("Email cannot be empty."));
      return;
    }
    emit(AuthLoading());
    try {
      await repo.resetPassword(email: email);
      emit(AuthResetPasswordSuccess());
    } catch (e) {
      emit(AuthFail("Failed to reset password: ${e.toString()}"));
    }
  }
}