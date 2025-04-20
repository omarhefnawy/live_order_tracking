import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_traking/features/auth/domain/repo/authrepo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo{
  final FirebaseAuth firebaseAuth;

  AuthRepoImpl(this.firebaseAuth);

  @override
  Future<UserCredential> signIn({required String email, required String password})async {
    // TODO: implement signIn
    try{
      return  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseException catch(e)
    {
      throw Exception("failed to Login ");
    }
    catch(e){
      throw Exception("failed to Login${e.toString()}");
    }
  }
  @override
  Future<UserCredential> signUp({required String email, required String password}) async{
    // TODO: implement signUp
    try{
      return await  firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseException catch(e)
    {
      throw Exception("failed to Sign Up");
    }
    catch(e){
      throw Exception("failed to Sign Up${e.toString()}");
    }
  }
  @override
  Future<void> logOut()async {
    // TODO: implement logOut
    try
    {
      await firebaseAuth.signOut();
    }
    on FirebaseException catch(e)
    {
      throw Exception("failed to Sign out");
    }
    catch(e){
      throw Exception("failed to Sign out${e.toString()}");
    }

  }
  //
  @override
  Future<void> resetPassword({required String email}) async{
    // TODO: implement resetPassword
    try
    {
       await firebaseAuth.sendPasswordResetEmail(email: email);
    }
    on FirebaseException catch(e)
    {
      throw Exception("failed to reset Password");
    }
    catch(e){
      throw Exception("failed reset Password${e.toString()}");
    }
  }
}