import 'package:flutter/material.dart'hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_bloc.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_event.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_state.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_detail_page/history_detail_page.dart';

class ConfirmProductsPage extends StatelessWidget {
  const ConfirmProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ConfirmProductsBloc();
    bloc.add(FetchUnconfirmedsEvent());
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(bloc),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Tasdiqlash",
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
      child: Column(
        children: [
         const SizedBox(height: 8,),
          _buildListView(bloc),
        ],
      ),
    );
  }

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }

  _buildListView(ConfirmProductsBloc bloc) {
    return BlocBuilder<ConfirmProductsBloc,ConfirmProductsState>(
      bloc: bloc,
      builder: (context,state) {
        final isLoading = state is FetchUnconfirmedsState && state.state == State.loading;
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isLoading ? 0 : bloc.unconfirmeds.length,
          itemBuilder: (context, index) {
            return _buildListItem(context,bloc,index);
          },
        );
      }
    );
  }

 

  _buildListItem(BuildContext context,ConfirmProductsBloc bloc,int index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 2,
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 3,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HistoryDetailPage();
                },
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
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
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.indigo,
                        child: CircleAvatar(
                          radius: 18,
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
                      Text(
                        "Falonchi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildCustomDivider(),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Qayerdan olib kelindi:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      SizedBox(
                        height: 16,
                        width: 80,
                        child: Marquee(
                          style: const TextStyle(fontSize: 16),
                          scrollAxis: Axis.horizontal,
                          fadingEdgeEndFraction: 0.2,
                          fadingEdgeStartFraction: 0.2,
                          text: "${bloc.unconfirmeds[index].tradePlaceName}" "         ",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Keltirilgan sana:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        bloc.unconfirmeds[index].date.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Holati:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 251, 18, 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Tasdiqlanmadi",
                            style: TextStyle(color: Colors.white),
                          ),
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
      ),
    );
  }
}
