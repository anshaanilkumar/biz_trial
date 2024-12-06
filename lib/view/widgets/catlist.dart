//

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/app_colors.dart';
import '../../common/textconstants.dart';
import '../../controller/app_controller.dart';
import '../homescreen/categoryproduct.dart';

class Cataglist extends StatelessWidget {
  const Cataglist({
    super.key,
    required this.controller,
  });

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingCategories.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.categories.isEmpty) {
        return Center(child: Text('No categories available.'));
      }

      // Return horizontal scrollable list of categories
      return Container(
        color: white,
        height: 100, // Adjust height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to CategoryProductPage
                  Get.to(() => CategoryProductPage(category: category));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Category Name
                        Text(
                          category.name ?? 'Unnamed Category',
                          style: NeededTextstyles.style1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
