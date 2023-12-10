import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_bloc.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_event.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_state.dart';

class ConfirmDetailsPage extends StatelessWidget {
  const ConfirmDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ConfirmProductsBloc(repo: GetIt.instance.get());
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    bloc.add(FetchUnconfirmedByIdEvent(
        transactionId: args["id"], status: args["tradeStatus"]));

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(bloc),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Batafsil",
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

  _buildBody(ConfirmProductsBloc bloc) {
    return SingleChildScrollView(
      child: BlocBuilder<ConfirmProductsBloc, ConfirmProductsState>(
          bloc: bloc,
          builder: (context, state) {
            return _buildListView(bloc);
          }),
    );
  }

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }

  _buildListView(ConfirmProductsBloc bloc) {
    return BlocBuilder<ConfirmProductsBloc, ConfirmProductsState>(
        bloc: bloc,
        builder: (context, state) {
          final isLoading = state is FetchUnconfirmedByIdState &&
              state.state == State.loading;
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: isLoading ? 0 : bloc.detailedUnconfirmeds.length,
            itemBuilder: (context, index) {
              return _buildListItem(bloc, index);
            },
          );
        });
  }

  _buildListItem(ConfirmProductsBloc bloc, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 3,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nomi:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bloc.detailedUnconfirmeds[index].name.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Soni:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bloc.detailedUnconfirmeds[index].quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Narxi:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${bloc.detailedUnconfirmeds[index].price}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sana:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bloc.detailedUnconfirmeds[index].date ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
