import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_bloc.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_event.dart';
import 'package:samo_techno_crm/ui/pages/products_page/products_state.dart';

class ProductModelsPage extends StatelessWidget {
  const ProductModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bloc = ProductsBloc(repo: GetIt.instance.get());
    bloc.add(
      FetchCategoryByIdEvent(
        id: args["id"],
      ),
    );

    return Scaffold(
      appBar: _buildAppBar(context, bloc, args),
      body: _buildBody(context, bloc, args),
    );
  }

  _buildBody(
      BuildContext context, ProductsBloc bloc, Map<String, dynamic> args) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildModelsList(bloc, args),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context, ProductsBloc bloc, Map args) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: BlocBuilder<ProductsBloc, ProductsState>(
        bloc: bloc,
        builder: (context, state) {
          return Text(
            args["category_item_name"] ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        },
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

  _buildCustomDivider() {
    return Container(
      height: 1,
      color: Colors.indigo,
    );
  }

  _buildModelsList(ProductsBloc bloc, Map<String, dynamic> args) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        final isLoading =
            state is FetchCategoryByIdState && state.state == State.loading;
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: isLoading ? 0 : bloc.productsById.length,
          itemBuilder: (context, index) {
            return _buildModel(bloc, index, isLoading, args);
          },
        );
      },
    );
  }

  _buildModel(
      ProductsBloc bloc, int index, bool isLoading, Map<String, dynamic> args) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: InkWell(
        onTap: () {
          bloc.add(
            TryToExpandEvent(
              index: index,
            ),
          );
        },
        child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16,
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      bloc.productsById[index].name ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(
                      bloc.isExpandedItems[index] == true
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
              bloc.isExpandedItems[index] == true
                  ? _buildModelChildList(bloc, index, isLoading, args)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _buildModelChildList(ProductsBloc bloc, int parentIndex, bool isLoading,
      Map<String, dynamic> args) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          isLoading ? 0 : bloc.productsById[parentIndex].children?.length,
      itemBuilder: (context, index) {
        return _buildModelChild(
            context, bloc, parentIndex, index, isLoading, args);
      },
    );
  }

  _buildModelChild(BuildContext context, ProductsBloc bloc, int parentIndex,
      int index, bool isLoading, Map<String, dynamic> args) {
    return Row(
      children: [
        Text(
          bloc.productsById[parentIndex].children?[index].name ?? "",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          "${bloc.productsById[parentIndex].children?[index].price} | ${bloc.productsById[parentIndex].children?[index].quantity}",
          style: const TextStyle(
            color: Colors.indigo,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
