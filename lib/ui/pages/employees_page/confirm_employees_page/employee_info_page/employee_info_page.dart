import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/add_product_page/add_product_state.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/confirm_employees_page/cofirm_employees_event.dart';
import 'package:samo_techno_crm/ui/pages/employees_page/confirm_employees_page/confirm_employees_bloc.dart';

class EmployeeInfoPage extends StatelessWidget {
  const EmployeeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ConfirmEmployeesBloc(repo: GetIt.instance.get());
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = args["id"];
    bloc.add(FetchEmployeeByIdEvent(id: args["id"]));
    print("iddddd  ${args["id"]}");

    return Scaffold(
      appBar: _buildAppBar(context, bloc, id),
      body: _buildBody(bloc),
    );
  }

  _buildBody(ConfirmEmployeesBloc bloc) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          final isLoading =
              state is FetchCategoryByIdState && state.state == State.loading;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              _buildEmployeeInfo(bloc, isLoading),
              const SizedBox(
                height: 8,
              ),
              _buildRoles(bloc, isLoading),
              _buildAddRole(),
            ],
          );
        });
  }

  _buildRoles(ConfirmEmployeesBloc bloc, bool isloading) {
    print("displayname${bloc.employeesById.roles?.first.displayName}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
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
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            bloc.employeesById.roles?.first.displayName ?? "",
            style: const TextStyle(
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

  _buildEmployeeInfo(ConfirmEmployeesBloc bloc, bool isLoading) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        const CircleAvatar(
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
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isLoading ? "" : bloc.employeesById.fio ?? "",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isLoading ? " " : bloc.employeesById.phoneNumber ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  _buildAppBar(BuildContext context, ConfirmEmployeesBloc bloc, int id) {
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
        BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              return Padding(
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
                              onPressed: () {
                                bloc.add(BlocUSerEvent(id: id));
                                Navigator.pop(context);
                              },
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
              );
            }),
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
