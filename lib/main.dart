import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:order_traking/core/network/local/cachHelper.dart';
import 'package:order_traking/features/auth/data/repo_imp/authRepoImp/auth_repo_imp.dart';
import 'package:order_traking/features/auth/domain/repo/authrepo/auth_repo.dart';
import 'package:order_traking/features/auth/presentation/auth_bloc/auth_cubit.dart';
import 'package:order_traking/features/auth/presentation/screens/login/login.dart';
import 'package:order_traking/features/auth/presentation/screens/regester/regester.dart';
import 'package:order_traking/features/home/presentation/screens/home.dart';
import 'package:order_traking/features/onboarding/onboardingScreen.dart';
import 'package:order_traking/features/orders/add_order/data/repo_impl/add_order_repo_imp.dart';
import 'package:order_traking/features/orders/add_order/prsentation/order_bloc/add_order_bloc.dart';
import 'package:order_traking/features/orders/add_order/prsentation/screens/add_order.dart';
import 'package:order_traking/features/orders/ordaratiy/screens/my_order.dart';
import 'package:order_traking/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CacheHelper.init();
  await dotenv.load(fileName: "keys.env");
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  AuthRepoImpl authRepo=AuthRepoImpl(firebaseAuth);
  AddOrderRepoImp addOrderRepo=AddOrderRepoImp(fireStore);
  runApp(MyApp(auth_repo: authRepo,addOrder_repo:addOrderRepo ));
}

class MyApp extends StatelessWidget {
 final AuthRepoImpl auth_repo;
 final AddOrderRepoImp addOrder_repo;
  const MyApp({super.key, required this.auth_repo, required this.addOrder_repo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(auth_repo),),
        BlocProvider(create: (context) => AddOrderCubit(addOrder_repo),),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Order Tracking',
        initialRoute: "/",
        routes:{
          "/":(context)=>SplashScreen(),
          "login":(context)=>LoginScreen(),
          "signUp":(context)=>RegisterScreen(),
          "onboarding":(context)=>OnboardingScreen(),
          "home":(context)=>HomeScreen(),
          "addOrder":(context)=>AddOrder(),
          "distinationLocation":(context)=>AddOrder(),
          "myOrders":(context)=>MyOrders(),
      
        },
      ),
    );
  }
}

