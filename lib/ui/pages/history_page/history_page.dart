import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:marquee/marquee.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_bloc.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_detail_page/history_detail_page.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_event.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = HistoryBloc(repo: GetIt.instance.get());
    bloc.scrlController.addListener(
      () {
        if (bloc.scrlController.position.pixels ==
            bloc.scrlController.position.maxScrollExtent) {
          bloc.add(FetchMoreEvent());
        }
      },
    );
    bloc.add(FetchHistoriesEvent());
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, bloc),
    );
  }

  _buildFilterBySell(HistoryBloc bloc) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: bloc,
      builder: (context, state) {
        final isLoading =
            state is FetchHistoriesState && state.state == State.loading;
        return isLoading
            ? const CupertinoActivityIndicator()
            : GestureDetector(
                onTap: () {
                  bloc.add(FilterChangeIsSellEvent());
                  bloc.add(FetchHistoriesEvent());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                    color: bloc.isSell ? Colors.red : Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      bloc.isSell ? "Sell" : "Buy",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Tarixlar",
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

  _buildBody(BuildContext context, HistoryBloc bloc) {
    return SingleChildScrollView(
      controller: bloc.scrlController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildFilterBySell(bloc),
              _buildDateFilterButton(context),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          _buildListView(bloc),
        ],
      ),
    );
  }

  _buildDateFilterButton(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                32,
              ),
              topRight: Radius.circular(
                32,
              ),
            ),
          ),
          context: context,
          builder: (BuildContext builder) {
            return SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  selectedDate = value;
                  print(
                    selectedDate.toString().substring(
                          0,
                          selectedDate.toString().indexOf(" "),
                        ),
                  );
                },
              ),
            );
          },
        ).then(
          (value) {},
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "Add date",
          style: TextStyle(
            color: Colors.indigo,
          ),
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

  _buildListView(HistoryBloc bloc) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        return current is FetchHistoriesState || current is FetchMoreState;
      },
      builder: (context, state) {
        final isLoading =
            state is FetchHistoriesState && state.state == State.loading;
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isLoading ? 0 : bloc.historyItems.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, bloc, index);
          },
        );
      },
    );
  }

  _buildListItem(BuildContext context, HistoryBloc bloc, int index) {
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
                settings: RouteSettings(
                  arguments: {
                    "id": bloc.historyItems[index].transactionId,
                  },
                ),
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
                  Row(
                    children: [
                      Text(
                        bloc.historyItems[index].fio.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Icon(
                        bloc.historyItems[index].status == "IN_PROGRESS"
                            ? Icons.error
                            : Icons.check_circle,
                        color: bloc.historyItems[index].status == "IN_PROGRESS"
                            ? Colors.yellow
                            : Colors.green,
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
                          text: "${bloc.historyItems[index].tradePlace}"
                              "         ",
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
                        bloc.historyItems[index].createdDate ?? "",
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
                        decoration: BoxDecoration(
                          color:
                              bloc.historyItems[index].status == "IN_PROGRESS"
                                  ? const Color.fromARGB(255, 251, 18, 2)
                                  : Colors.green,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            bloc.historyItems[index].status == "IN_PROGRESS"
                                ? "Tasdiqlanmadi"
                                : "Tasdiqlandi",
                            style: const TextStyle(color: Colors.white),
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
