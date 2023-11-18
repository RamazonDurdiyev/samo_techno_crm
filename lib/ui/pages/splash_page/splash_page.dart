import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_page.dart';
import 'package:samo_techno_crm/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_event.dart';
import 'package:samo_techno_crm/ui/pages/splash_page/splash_state.dart';

import 'splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SplashBloc();
    return Scaffold(
      body: _buildBody(bloc),
    );
  }

  _buildBody(SplashBloc bloc) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is CheckUserState,
      listener: (context, state) {
        if (bloc.user.isNotEmpty == true) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const SignInPage();
            },
          ), (route) => false);
        }
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.indigo,
        child: _buildCenterText(bloc),
      ),
    );
  }

  _buildCenterText(SplashBloc bloc) {
    return Center(
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        animatedTexts: [
          TyperAnimatedText(
            "Samo Techno",
            speed: const Duration(milliseconds: 100),
            textStyle: const TextStyle(
              color: Colors.white,
              fontFamily: "Kdam",
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        onFinished: () {
          bloc.add(CheckUserEvent());
        },
      ),
    );
  }
}
