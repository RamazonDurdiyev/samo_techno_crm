import 'package:flutter/material.dart';
import 'package:samo_techno_crm/ui/pages/confirm_employees_page/add_employee_page/add_employee_page.dart';
import 'package:samo_techno_crm/ui/pages/confirm_employees_page/employee_info_page/employee_info_page.dart';

class ConfirmEmployeesPage extends StatelessWidget {
  const ConfirmEmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AddEmployeePage();
            },
          ),
        );
      },
      backgroundColor: Colors.indigo,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Hodimlar",
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

  _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              _buildListView(),
            ],
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

  _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildListItem(context);
      },
    );
  }

  _buildListItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const EmployeeInfoPage();
              },
            ),
          );
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 3,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.indigo,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_2,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Falonchiyev Pistonchi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
