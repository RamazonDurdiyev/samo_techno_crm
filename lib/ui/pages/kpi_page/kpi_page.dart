import 'package:flutter/material.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_detail_page/history_detail_page.dart';

class KPIPage extends StatelessWidget {
  const KPIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: _buildFloatingButton(),
      body: _buildBody(),
    );
  }

  _buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo,
      onPressed: () {},
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
        "KPI amallari",
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildListView(),
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

  _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildListItem(context);
      },
    );
  }

  _buildListItem(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Falonchi",
                    style: TextStyle(
                      fontSize: 16,
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
                  const Row(
                    children: [
                      Text(
                        "Xodim:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "Elyor Mavlonov",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "Tel:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "+9987778899",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "Mahsulot:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "Monitor",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Sana:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        DateTime.now().toString().substring(0, 16),
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
      ),
    );
  }
}
