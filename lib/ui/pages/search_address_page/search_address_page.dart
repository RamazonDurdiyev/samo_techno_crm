import 'dart:async';

import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/add_product_page/add_product_page.dart';
import 'package:samo_techno_crm/ui/pages/remove_products_page/remove_products_page.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_bloc.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_state.dart';
import 'search_address_event.dart';

class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SearchAddressBloc(repo: GetIt.instance.get());
    final arg = ModalRoute.of(context)!.settings.arguments as String;
    bloc.add(ShowToastEvent());
    bloc.add(GetAllPlacesEvent(status: arg));
    return Scaffold(
      body: _buildBody(context, bloc, arg),
    );
  }

  _buildBody(BuildContext context, SearchAddressBloc bloc, String arg) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().statusBarHeight + 8,
        ),
        _buildSearchTextField(context, bloc, arg),
        const SizedBox(
          height: 8,
        ),
        _buildCustomDivider(),
        _buildListView(bloc, arg),
      ],
    );
  }

  _buildEmptyText() {
    return const Center(
      child: Text(
        "Mahsulot yo`q",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  _buildListView(SearchAddressBloc bloc, String arg) {
    return Expanded(
      child: BlocBuilder<SearchAddressBloc, SearchAddressState>(
        bloc: bloc,
        builder: (context, state) {
          final isLoading =
              state is GetAllPlacesState && state.state == State.loading ||
                  state is SearchPlaceState && state.state == State.loading;
          return isLoading
              ? const CupertinoActivityIndicator()
              : (bloc.searchAddressCtrl.text.isEmpty &&
                          bloc.allPlaces.isNotEmpty ||
                      bloc.searchAddressCtrl.text.isNotEmpty &&
                          bloc.searchedPlaces.isNotEmpty)
                  ? ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: bloc.searchAddressCtrl.text.isEmpty
                          ? (isLoading ? 0 : bloc.allPlaces.length)
                          : (isLoading ? 0 : bloc.searchedPlaces.length),
                      itemBuilder: (context, index) {
                        return _buildListItem(context, bloc, index, arg);
                      },
                    )
                  : _buildEmptyText();
        },
      ),
    );
  }

  _buildListItem(
      BuildContext context, SearchAddressBloc bloc, int index, String arg) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text(
                  "Tasdiqlash",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  "Manzilni tasdiqlashni istaysizmi?",
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      bloc.add(
                        SelectAddressEvent(
                          place: bloc.searchAddressCtrl.text.isEmpty
                              ? bloc.allPlaces[index]
                              : bloc.searchedPlaces[index],
                          isSell: arg == "BUY" ? false : true,
                        ),
                      );
                      Navigator.of(context).pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return arg == "BUY"
                                ? const AddProductPage()
                                : const RemoveProductsPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Ha",
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
                      "Yo`q",
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    bloc.searchAddressCtrl.text.isEmpty
                        ? bloc.allPlaces[index].name ?? ""
                        : bloc.searchedPlaces[index].name ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
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

  _buildSearchTextField(
      BuildContext context, SearchAddressBloc bloc, String arg) {
    return BlocBuilder<SearchAddressBloc, SearchAddressState>(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  _buildBackButton(context),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      controller: bloc.searchAddressCtrl,
                      cursorColor: Colors.indigo,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.indigo,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        hintText: "Manzil izlash",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "Lato",
                        ),
                        fillColor: Color.fromARGB(255, 236, 234, 234),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _searchComplex(bloc, arg, bloc.searchAddressCtrl);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 50,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 234, 234),
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.indigo,
        ),
      ),
    );
  }

  void _searchComplex(
      SearchAddressBloc bloc, String arg, TextEditingController controller) {
    bloc.timer?.cancel();
    bloc.timer = Timer(
      const Duration(milliseconds: 1000),
      () {
        bloc.add(
          SearchPlaceEvent(
            status: arg,
            name: controller.text,
          ),
        );
      },
    );
  }
}
