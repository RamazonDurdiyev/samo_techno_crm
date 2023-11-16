import 'package:flutter/material.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildBody() {
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
          TextEditingController(),
          "Phone number",
          TextInputType.phone,
        ),
        const SizedBox(
          height: 8,
        ),
        _buildTextField(
          TextEditingController(),
          "Password",
          TextInputType.text,
        )
      ],
    );
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
