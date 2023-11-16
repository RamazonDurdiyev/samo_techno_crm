import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samo_techno_crm/ui/pages/add_product_page/add_product_page.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_bloc.dart';
import 'search_address_event.dart';

class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SearchAddressBloc();
    bloc.add(ShowToastEvent());
    return Scaffold(
      body: _buildBody(context, bloc),
    );
  }

  _buildBody(BuildContext context, SearchAddressBloc bloc) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().statusBarHeight + 8,
        ),
        _buildSearchTextField(context, bloc),
        const SizedBox(
          height: 8,
        ),
        _buildCustomDivider(),
        _buildListView(),
        _buildConfirmButton(context),
      ],
    );
  }

  _buildListView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buildListParts();
        },
      ),
    );
  }

  _buildListParts() {
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
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                "Abu-saxiy bozori",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

  _buildConfirmButton(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 236, 234, 234),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddProductPage();
                },
              ),
            );
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

  _buildSearchTextField(BuildContext context, SearchAddressBloc bloc) {
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
              ),
            ),
          ],
        ),
      ),
    );
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
}
