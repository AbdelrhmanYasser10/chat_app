import 'package:chat_application_it/layout/main_layout.dart';
import 'package:chat_application_it/screens/register_screen.dart';
import 'package:chat_application_it/shared/cubits/app_cubit/app_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   /*Don't forget options*/
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AppCubit()
        ..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            if(state is UserDataLoading){
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if(state is UserDataError){
              return const RegisterScreen();
            }
            else{
              return const MainLayout();
            }
          },
        ),
      ),
    );
  }
}
