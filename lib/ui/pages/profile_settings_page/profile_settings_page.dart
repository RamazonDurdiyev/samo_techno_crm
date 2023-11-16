import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_bloc.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_event.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_state.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ProfileSettingsBloc();
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(bloc),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.indigo,
      title: const Text(
        "Profile settings",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildUserImageCircle(BuildContext context, ProfileSettingsBloc bloc) {
    return Card(
      elevation: 5,
      shadowColor: Colors.indigo,
      shape: const CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.indigo,
        radius: 43,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text(
                    "Allow gallery?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    "The app needs to open gallery for images from gallery?",
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        bloc.add(
                          PickImageEvent(),
                        );
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_2,
              size: 32,
              color: Colors.indigo,
            ),
          ),
        ),
      ),
    );
  }

  _buildSeparateText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildBody(ProfileSettingsBloc bloc) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              _buildUserImageCircle(context, bloc),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  _buildSeparateText("Edit name"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(TextEditingController(), "Full name",TextInputType.text,),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  _buildSeparateText("Edit phone number"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(TextEditingController(), "Phone number",TextInputType.phone,),
            ],
          ),
        );
      },
    );
  }

  _buildTextField(TextEditingController ctrl, String hint,keyType) {
    return SizedBox(
      child: TextField(
        controller: ctrl,
        keyboardType: keyType,
        cursorColor: Colors.indigo,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
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
    );
  }
}
