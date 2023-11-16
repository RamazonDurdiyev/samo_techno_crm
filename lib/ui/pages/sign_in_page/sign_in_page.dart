import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_page.dart';
import 'package:samo_techno_crm/ui/pages/sign_in_page/sign_in_bloc.dart';
import 'package:samo_techno_crm/ui/pages/sign_in_page/sign_in_event.dart';
import 'package:samo_techno_crm/ui/pages/sign_in_page/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SignInBloc();
    GlobalKey<FormState> phoneKey = GlobalKey();
    GlobalKey<FormState> passwordKey = GlobalKey();
    return Scaffold(
      body: _buildBody(context, bloc, phoneKey, passwordKey),
    );
  }

  _buildBody(BuildContext context, SignInBloc bloc,
      GlobalKey<FormState> phoneKey, GlobalKey<FormState> passwordKey) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        _buildTextField(
          bloc.phoneCtrl,
          bloc,
          "Phone number",
          phoneKey,
        ),
        const SizedBox(
          height: 8,
        ),
        _buildPasswordTextField(
          bloc.passwordCtrl,
          bloc,
          "Password",
          passwordKey,
        ),
        const SizedBox(
          height: 16,
        ),
        _buildSignButton(context, bloc, phoneKey, passwordKey),
      ],
    );
  }

  _buildSignButton(BuildContext context, SignInBloc bloc,
      GlobalKey<FormState> phoneKey, GlobalKey<FormState> passwordKey) {
    return BlocListener<SignInBloc, SignInState>(
      bloc: bloc,
      listenWhen: (previous, current) => current is LoginState,
      listener: (context, state) {
        final loadedSucces = state is LoginState &&
            state.state == State.loaded &&
            bloc.user.id != null;
        final isError = state is LoginState && state.state == State.error;
        if (loadedSucces == true) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ), (route) => false);
        } else if (isError == true) {
          Fluttertoast.showToast(
            msg: "Something went wrong!",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            if (phoneKey.currentState!.validate() &&
                passwordKey.currentState!.validate()) {
              bloc.add(LoginEvent());
              // if (!isLoading && bloc.user.id != null) {
              //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              //     builder: (context) {
              //       return const HomePage();
              //     },
              //   ), (route) => false);
              // }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            backgroundColor: Colors.indigo,
            fixedSize: const Size(
              double.maxFinite,
              60,
            ),
          ),
          child: const Text(
            "Sign In",
          ),
        ),
      ),
    );
  }

  _buildTextField(TextEditingController ctrl, SignInBloc bloc, String hint,
      GlobalKey<FormState> key) {
    final RegExp phoneRegExp = RegExp(
        r'^\+998(33|88|91|93|94|95|97|98|99|90|77|55|66|10|11|12|14|15|16|17)[0-9]{7}$');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Form(
          key: key,
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return "Phone number is required";
              } else if (!phoneRegExp.hasMatch(value)) {
                return "Enter correct phone number";
              }
              return null;
            },
            controller: ctrl,
            keyboardType: TextInputType.phone,
            cursorColor: Colors.indigo,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.call,
                color: Colors.grey,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Colors.grey, fontSize: 16, fontFamily: "Lato"),
              fillColor: const Color.fromARGB(255, 236, 234, 234),
              filled: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );
  }

  _buildPasswordTextField(TextEditingController passwordCtrl, SignInBloc bloc,
      String hint, GlobalKey<FormState> passwordKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Form(
          key: passwordKey,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return "Password length must not less then 6 characters";
              }
              return null;
            },
            controller: bloc.passwordCtrl,
            cursorColor: Colors.indigo,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.call,
                color: Colors.grey,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Colors.grey, fontSize: 16, fontFamily: "Lato"),
              fillColor: const Color.fromARGB(255, 236, 234, 234),
              filled: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );
  }
}
