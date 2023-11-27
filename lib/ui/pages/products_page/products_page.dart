

import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/products_cart_page/products_cart_page.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_bloc.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_event.dart';

import 'product_model_page/products_model_page.dart';
import 'products_state.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ProductsBloc(repo: GetIt.instance.get());
    bloc.add(FetchCategoriesEvent());
    return Scaffold(
      appBar: _buildAppBar(context, bloc),
      body: _buildBody(bloc),
    );
  }

  _buildAppBar(BuildContext context, ProductsBloc bloc) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: _buildSearchTextField(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: GestureDetector(
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
              Icons.shopping_cart_outlined,
              color: Colors.indigo,
              size: 28,
            ),
          ),
        ),
      ],
      leadingWidth: 32,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.indigo,
          ),
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
            _buildFilterTab(bloc),
          ],
        ),
      ),
    );
  }

  _buildBody(ProductsBloc bloc) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildListView(bloc),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  _buildSearchTextField() {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: TextEditingController(),
        cursorColor: Colors.indigo,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.indigo,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: "Qidirish...",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 16, fontFamily: "Lato"),
          fillColor: Color.fromARGB(255, 236, 234, 234),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide.none),
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

  _buildFilterTab(ProductsBloc bloc) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      bloc: bloc,
      builder: (context, state) {
        final isloading =
            state is AddFetchCategoriesState && state.state == State.loading;
        return DefaultTabController(
          length: bloc.categoriesList.length,
          initialIndex: bloc.currentIndexOfTab,
          child: TabBar(
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
                  ChangeTabEvent(value: value),
                );
              },
              tabs: bloc.categoriesList
                  .map(
                    (e) => Tab(
                      height: 35,
                      text: isloading ? "" : e.name,
                    ),
                  )
                  .toList()),
        );
      },
    );
  }

  _buildListView(ProductsBloc bloc) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      bloc: bloc,
      builder: (context, state) {
        final isloading =
            state is AddFetchCategoriesState && state.state == State.loading;
        return bloc.currentIndexOfTab >= 0 &&
                bloc.currentIndexOfTab < bloc.categoriesList.length
            ? ListView.builder(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isloading
                    ? 0
                    : bloc.categoriesList[bloc.currentIndexOfTab].categoryItems
                            ?.length ??
                        0,
                itemBuilder: (context, index) {
                  return _buildListItem(context, bloc, index, isloading);
                },
              )
            : const SizedBox();
      },
    );
  }

  _buildListItem(
      BuildContext context, ProductsBloc bloc, int index, bool isloading) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ProductModelsPage();
              },
              settings: RouteSettings(
                arguments: {
                  "id": bloc.categoriesList[index].id,
                  "category_item_name": bloc
                      .categoriesList[bloc.currentIndexOfTab]
                      .categoryItems?[index]
                      .title,
                },
              ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.widgets_sharp,
                  color: Colors.indigo,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  isloading
                      ? ""
                      : bloc.categoriesList[bloc.currentIndexOfTab]
                              .categoryItems?[index].title
                              .toString() ??
                          "",
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
    );
  }
}
