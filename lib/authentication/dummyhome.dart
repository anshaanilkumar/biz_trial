import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String companyName;

  const HomePage({Key? key, required this.companyName}) : super(key: key);

  Future<String> fetchShopName() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    return companyName; // Return the passed company name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FutureBuilder<String>(
          future: fetchShopName(), // Fetch company name asynchronously
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error loading shop name");
            } else {
              return Text("Hi ${snapshot.data}");
            }
          },
        ),
      ),
      body: Center(
        child: Text("Company Name: $companyName"),
      ),
    );
  }
}
