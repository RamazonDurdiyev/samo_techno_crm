import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/add_employee_page/add_employee_bloc.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/add_employee_page/add_employee_event.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AddEmployeeBloc(repo: GetIt.instance.get());
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(bloc),
    );
  }

  _buildBody(AddEmployeeBloc bloc) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              _buildSeparatedText(),
              const SizedBox(
                height: 16,
              ),
              _buildTextField(
                bloc.phoneNumberCtrl,
                "Phone number",
                TextInputType.phone,
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                bloc.passwordCtrl,
                "Password",
                TextInputType.text,
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                bloc.fioCtrl,
                "FIO",
                TextInputType.text,
              ),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                bloc.roleCtrl,
                "Role",
                TextInputType.text,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: () {
                      bloc.add(PostUserEvent());
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
                    child: const Text("Submit")),
              ),
            ],
          );
        });
  }

  _buildSeparatedText() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Text(
        "Fill boxes below",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildTextField(TextEditingController ctrl, String hint, keyType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
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
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Hodim tayinlash",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          size: 28,
          color: Colors.indigo,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 0),
        child: Column(
          children: [
            _buildCustomDivider(),
          ],
        ),
      ),
    );
  }

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }
}
