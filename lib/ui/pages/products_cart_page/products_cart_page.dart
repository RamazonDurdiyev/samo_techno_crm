import 'dart:convert';
import 'package:flutter/cupertino.dart' hide State;
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samo_techno_crm/models/cart_product/cart_product_model.dart';
import 'package:samo_techno_crm/models/place_model/place_model.dart';
import 'package:samo_techno_crm/models/product_model/product_model.dart';
import 'package:samo_techno_crm/models/remove_product/remove_product_model.dart';
import 'package:samo_techno_crm/ui/pages/products_cart_page/products_cart_state.dart';
import 'products_cart_bloc.dart';
import 'products_cart_event.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = ProductsCartBloc(repo: GetIt.instance.get());
    bloc.add(GetLocalProductsEvent());
    return Scaffold(
      appBar: _buildAppBar(context, bloc),
      body: _buildBody(context, bloc),
    );
  }

  _buildBody(
    BuildContext context,
    ProductsCartBloc bloc,
  ) {
    return BlocBuilder<ProductsCartBloc, ProductsCartState>(
      bloc: bloc,
      builder: (context, state) {
        return bloc.localProducts.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  _buildAddressText(bloc),
                  SizedBox(
                    height: bloc.selectedPlace.isNotEmpty == true ? 8 : 0,
                  ),
                  _buildProductsList(bloc),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildConfirmButton(context, bloc),
                ],
              )
            : _buildEmptyText();
      },
    );
  }

  _buildAddressText(ProductsCartBloc bloc) {
    return bloc.selectedPlace.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              bloc.isSell == true
                  ? "Yuborish manzili: ${PlaceModel.fromJson(
                      json.decode(
                        bloc.selectedPlace,
                      ),
                    ).name}"
                  : "Olib kelindi: ${PlaceModel.fromJson(
                      json.decode(
                        bloc.selectedPlace,
                      ),
                    ).name}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : const SizedBox();
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

  _buildConfirmButton(BuildContext context, ProductsCartBloc bloc) {
    return Container(
      color: const Color.fromARGB(255, 236, 234, 234),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (bloc.selectedPlace.isNotEmpty == true &&
                PlaceModel.fromJson(json.decode(bloc.selectedPlace)).id !=
                    null &&
                bloc.localProducts.isNotEmpty == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      bloc.isSell == true
                          ? "Mahsulot chiqarish"
                          : "Mahsulot qo`shish",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      bloc.isSell == true
                          ? "Mahsulotlarni chiqarmoqchimisiz?"
                          : "Mahsulotlarni qo`shmoqchimisiz?",
                      style: const TextStyle(fontSize: 16),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          bloc.isSell == true
                              ? bloc.add(
                                  DeleteProductEvent(
                                    productDelete: bloc.localProducts
                                        .map<DeleteProductModel>(
                                      (e) {
                                        return DeleteProductModel.fromJson(
                                          json.decode(e),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                )
                              : bloc.add(
                                  PostProductEvent(
                                    newProducts: bloc.localProducts
                                        .map<PostProductModel>(
                                      (e) {
                                        return PostProductModel.fromJson(
                                          json.decode(e),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                          bloc.add(DeleteAllLocalProductsEvent());
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Ha",
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
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      "Ma`lumotlar to`liq emas!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      "Ma`lumotlar to`liq kiritilmagan ma`lumotlarni to`liq kiritib qayta urinib ko`ring",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(
                          "Ok",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            backgroundColor: Colors.indigo,
            fixedSize: const Size(
              double.maxFinite,
              50,
            ),
          ),
          child: const Text(
            "Tasdiqlash",
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context, ProductsCartBloc bloc) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Savat",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      "Mahsulotlarni o`chirish",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      "Savatdagi mahsulotlarni ochirmoqchimisiz?",
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          bloc.add(DeleteAllLocalProductsEvent());
                          Navigator.pop(context);
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
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.indigo,
              size: 28,
            ),
          ),
        ),
      ],
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

  _buildProductsList(ProductsCartBloc bloc) {
    return BlocBuilder<ProductsCartBloc, ProductsCartState>(
      bloc: bloc,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            itemCount: bloc.categoryNames.length,
            itemBuilder: (context, index) {
              return _buildProductsItem(
                bloc,
                index,
                bloc.categoryNames[index] ?? "",
              );
            },
          ),
        );
      },
    );
  }

  _buildProductsItem(
    ProductsCartBloc bloc,
    int parentIndex,
    String categoryName,
  ) {
    return GestureDetector(
      onTap: () {
        bloc.add(TryToExpandEvent(index: parentIndex));
        bloc.add(SortProductsEvent(categoryName: categoryName));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      bloc.isItemExpanded[parentIndex] == false
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              bloc.isItemExpanded[parentIndex] == true
                  ? _buildProductsChildList(bloc, categoryName)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _buildProductsChildList(ProductsCartBloc bloc, String categoryName) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: bloc.sortProducts.length,
      itemBuilder: (context, index) {
        return _buildProductsChild(context, bloc, index, bloc.sortProducts);
      },
    );
  }

  _buildProductsChild(
    BuildContext context,
    ProductsCartBloc bloc,
    int index,
    List<String> list,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            CartProductModel.fromJson(json.decode(list[index])).name.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                100,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          16,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Tahrirlash",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: _buildTextField(bloc.countCtrl, "Sonini kiriting"),
                  );
                },
              );
            },
            child: const Icon(
              Icons.edit,
              size: 18,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              bloc.add(
                DeleteLocalProductEvent(
                  product: CartProductModel.fromJson(
                    json.decode(
                      list[index],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.remove_circle,
              color: Colors.red,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  _buildTextField(TextEditingController ctrl, String hint) {
    return SizedBox(
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        cursorColor: Colors.indigo,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 16, fontFamily: "Lato"),
          fillColor: const Color.fromARGB(255, 236, 234, 234),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
