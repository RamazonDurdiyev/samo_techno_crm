import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildListItem();
        },
      ),
    );
  }

  _buildListItem() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
        ),
        elevation: 3,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  color: Colors.indigo,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Facebook",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Hello everybody! This app name is Facebook and this app helps you for search new friends by social media and search people you interested ",
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
