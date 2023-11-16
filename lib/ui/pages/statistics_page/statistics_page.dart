import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/statistics_page/statistics_state.dart';

import 'statistics_bloc.dart';
import 'statistics_event.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StatisticsBloc();
    return DefaultTabController(
      length: 5,
      initialIndex: bloc.currentIndexOfTab,
      child: Scaffold(
        appBar: _buildAppBar(context, bloc),
        body: _buildBody(context, bloc),
      ),
    );
  }

  _buildBody(BuildContext context, StatisticsBloc bloc) {
    return TabBarView(
      children: _buildPages(context, bloc),
    );
  }

  _buildPages(BuildContext context, StatisticsBloc bloc) {
    return List.generate(
      5,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              _buildCard("Ombordagi mahsulotlar", 1250, 1500000),
              const SizedBox(
                height: 8,
              ),
              _buildDateFilters(context, bloc),
              const SizedBox(
                height: 8,
              ),
              _buildCard("Kirim", 2500, 47000),
              const SizedBox(
                height: 8,
              ),
              _buildCard("Chiqim", 3200, 52000),
            ],
          ),
        );
      },
    );
  }

  _buildDateFilters(BuildContext context, StatisticsBloc bloc) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
        bloc: bloc,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  _buildBottomSheet(context, bloc);
                },
                child: const Row(
                  children: [
                    Text("Start Date"),
                    Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                height: 18,
                width: 2,
                color: Colors.indigo,
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text("End Date"),
                    Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _buildBottomSheet(BuildContext context, StatisticsBloc bloc) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(8),
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
            },
          ),
        );
      },
    ).then((value) {
      // bloc.add(BackendGo(value: currentDate));
    });
  }

  _buildCard(String title, int productCount, double sum) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
                  "Jami mahsulotlar soni:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  productCount.toString(),
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Summasi:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  sum.toString(),
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context, StatisticsBloc bloc) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.indigo,
      ),
      backgroundColor: Colors.transparent,
      title: const Text(
        "Statistics",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 44),
        child: Column(
          children: [
            _buildCustomDivider(),
            const SizedBox(
              height: 8,
            ),
            _buildTabBar(bloc),
          ],
        ),
      ),
    );
  }

  _buildTabBar(StatisticsBloc bloc) {
    return TabBar(
      padding: const EdgeInsets.only(left: 16),
      isScrollable: true,
      splashBorderRadius: const BorderRadius.all(
        Radius.circular(
          100,
        ),
      ),
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.white,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            100,
          ),
        ),
        color: Colors.indigo,
      ),
      onTap: (value) {
        bloc.add(
          ChangeStatisticsTabEvent(value: value),
        );
      },
      tabs: _buildTabs(),
    );
  }

  _buildTabs() {
    return List.generate(
      5,
      (index) {
        return const Tab(
          height: 35,
          text: "Tayyor",
        );
      },
    );
  }

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }
}
