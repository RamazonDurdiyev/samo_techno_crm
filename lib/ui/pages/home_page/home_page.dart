import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_bloc.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_event.dart';
import 'package:samo_techno_crm/ui/pages/home_page/home_state.dart';
import 'package:samo_techno_crm/ui/pages/products_cart_page/products_cart_page.dart';
import 'package:samo_techno_crm/ui/pages/confirm_employees_page/confirm_employees_page.dart';
import 'package:samo_techno_crm/ui/pages/confirm_products_page/confirm_products_page.dart';
import 'package:samo_techno_crm/ui/pages/defects_page/defects_page.dart';
import 'package:samo_techno_crm/ui/pages/history_page/history_page.dart';
import 'package:samo_techno_crm/ui/pages/kpi_page/kpi_page.dart';
import 'package:samo_techno_crm/ui/pages/notification_page/notification_page.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_page.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_page.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_page.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_page.dart';
import 'package:samo_techno_crm/ui/pages/settings_page/settings_page.dart';
import 'package:samo_techno_crm/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:samo_techno_crm/ui/widgets/chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc();
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context, bloc),
      body: _buildBody(context),
    );
  }

  _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Samo Techno",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const NotificationPage();
                },
              ),
            );
          },
          child: const Icon(
            Icons.notifications,
            color: Colors.indigo,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CartPage();
                },
              ),
            );
          },
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.analytics,
              size: 40,
              color: Colors.indigo,
            ),
          );
        },
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

  _buildDrawer(BuildContext context, HomeBloc bloc) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          return Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.indigo),
                  accountName: const Text(
                    'Hamroyev Shavkat',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Row(
                    children: [
                      const Text(
                        'Shavkat3245@gmail.com',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ProfileSettings();
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_2,
                      size: 32,
                      color: Colors.indigo,
                    ),
                    // backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.indigo,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SettingsPage();
                        },
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Colors.indigo,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.indigo,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text(
                            "Log out?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            "Are you sure to log out your account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {
                                bloc.add(RemoveUserEvent());
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const SignInPage();
                                  },
                                ), (route) => false);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
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
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  _buildSeparateText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          _buildSeparateText("Analytics"),
          const SizedBox(
            height: 8,
          ),
          DynamicChart(),
          const SizedBox(
            height: 8,
          ),
          _buildSeparateText("Actions"),
          const SizedBox(
            height: 8,
          ),
          _buildCarousel(context),
          const SizedBox(
            height: 8,
          ),
          _buildSeparateText("Services"),
          const SizedBox(
            height: 8,
          ),
          _buildServicesGrid(context),
        ],
      ),
    );
  }

  _buildCarousel(BuildContext context) {
    return CarouselSlider(
      items: [
        _buildCarouselItem(
          context,
          Icons.add_circle,
          "Mahsulot kiritish",
          const SearchAddressPage(),
        ),
        _buildCarouselItem(
          context,
          Icons.remove_circle,
          "Mahsulot chiqarish",
          const RemoveProductsPage(),
        ),
      ],
      options:
          CarouselOptions(height: 100, aspectRatio: 2, viewportFraction: 0.9),
    );
  }

  _buildCarouselItem(
      BuildContext context, IconData icon, String text, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return page;
            },
          ),
        );
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
        ),
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.indigo,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.indigo,
                size: 44,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildServicesGrid(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 3,
      ),
      children: [
        _serviceButton(
          context,
          const Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          "Omborda mavjud mahsulotlar",
          const ProductsPage(),
        ),
        _serviceButton(
          context,
          const Icon(
            Icons.warning,
            color: Colors.white,
          ),
          "Yaroqsiz mahsulotlar",
          const DefectsPage(),
        ),
        _serviceButton(
          context,
          const Icon(
            Icons.history,
            color: Colors.white,
          ),
          "Kirim chiqim tarixi",
          const HistoryPage(),
        ),
        _serviceButton(
          context,
          const Icon(
            Icons.people,
            color: Colors.white,
          ),
          "Hodimlarni tayinlash",
          const ConfirmEmployeesPage(),
        ),
        _serviceButton(
          context,
          const Icon(
            Icons.library_books,
            color: Colors.white,
          ),
          "KPI amallari",
          const KPIPage(),
        ),
        _serviceButton(
          context,
          const Icon(
            Icons.check_box,
            color: Colors.white,
          ),
          "Mahsulotlarni tasdiqlash",
          const ConfirmProductsPage(),
        ),
      ],
    );
  }

  _serviceButton(
    BuildContext context,
    Icon icon,
    String task,
    page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return page;
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
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo,
                ),
                child: icon,
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      task,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
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
}
