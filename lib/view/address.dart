import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/usercontroller.dart';


class ChangeAddressPage extends StatefulWidget {
  final String currentAddress;

  const ChangeAddressPage({required this.currentAddress, Key? key}) : super(key: key);

  @override
  _ChangeAddressPageState createState() => _ChangeAddressPageState();
}

class _ChangeAddressPageState extends State<ChangeAddressPage> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = widget.currentAddress; // Set initial address
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Address")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Address"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<UserController>().updateAddress(_addressController.text); // Update address
                Get.back(); // Go back to the previous screen
              },
              child: Text("Save Address"),
            ),
          ],
        ),
      ),
    );
  }
}
