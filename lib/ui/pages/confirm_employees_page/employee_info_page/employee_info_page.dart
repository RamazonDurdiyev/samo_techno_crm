import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeInfoPage extends StatelessWidget {
  const EmployeeInfoPage({super.key});

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
        _buildEmployeeInfo(),
        const SizedBox(
          height: 8,
        ),
        _buildRoles(),
        _buildAddRole(),
      ],
    );
  }

  _buildRoles() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            "Roles",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            "Manager, Buxgalter",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  _buildAddRole() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.add_circle,
          color: Colors.indigo,
        ),
        label: const Text(
          "add role",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildEmployeeInfo() {
    return const Row(
      children: [
        SizedBox(
          width: 16,
        ),
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.indigo,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_2,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Falonchiyev Pistonchi",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "+9989998877",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 16,
        ),
      ],
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
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      "Block employee?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      "Are you sure to block this employee?",
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {},
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.person_off,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }
}
