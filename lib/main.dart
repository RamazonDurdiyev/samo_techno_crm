import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_bloc.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<SplashBloc>(
          create: (context) {
            return SplashBloc();
          },
          child: const SplashPage(),
        ),
      ),
    );
  }
}
